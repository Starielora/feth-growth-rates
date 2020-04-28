#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QList>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QDebug>
#include <QDirIterator>

#include "FETHCharacter.h"
#include "FETHClass.h"
#include "FETHGrowthRates.h"

#include <exception>
#include <memory>

QJsonDocument loadJson(const QString path);
QList<FETHCharacter*> loadCharacters();
QList<FETHClass*> loadClasses();
template<class T>
void setParent(const QList<T>&, QObject* const);

int main(int argc, char *argv[]) try
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterUncreatableType<FETHGrowthRates>("feth", 1, 0, "FETHGrowthRates", "FETHGrowthRates instances are provided by the application");
    qmlRegisterUncreatableType<FETHCharacter>("feth", 1, 0, "FETHCharacter", "FETHCharacter instances are provided by the application");
    qmlRegisterUncreatableType<FETHClass>("feth", 1, 0, "FETHClass", "FETHClass instance is provided by the application");

    auto feClasses = loadClasses();
    auto feCharacters = loadCharacters();

    std::sort(feClasses.begin(), feClasses.end(), [](const FETHClass* const left, const FETHClass* const right){
        const auto leftIndex = left->getClassTypeOrderIndex();
        const auto rightIndex = right->getClassTypeOrderIndex();
        return leftIndex < rightIndex;
    });

    std::sort(feCharacters.begin(), feCharacters.end(), [](const FETHCharacter* const left, const FETHCharacter* const right){
        const auto leftIndex = left->getHouseOrderIndex();
        const auto rightIndex = right->getHouseOrderIndex();
        return leftIndex < rightIndex;
    });

    setParent(feClasses, &app);
    setParent(feCharacters, &app);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("characterClasses", QVariant::fromValue(feClasses)); // TODO delete feClasses
    engine.rootContext()->setContextProperty("characters", QVariant::fromValue(feCharacters));

    engine.load(QUrl("qrc:///qml/main.qml"));

    if (engine.rootObjects().isEmpty())
    {
        return EXIT_FAILURE;
    }

    return app.exec();

}
catch(const std::runtime_error& e)
{
    qDebug() << e.what();
    return EXIT_FAILURE;
}

template<class T>
void setParent(const QList<T>& list, QObject* const p)
{
    for(const auto& elem : list)
    {
        elem->setParent(p);
    }
}

QJsonObject toObject(const QJsonValue& val)
{
    if(!val.isObject())
    {
        throw std::runtime_error("Value is not a json object.");
    }

    return val.toObject();
}

QJsonObject getObject(const QString& name, const QJsonObject& json)
{
    if(!json.contains(name))
    {
        throw std::runtime_error("Json object does not contain key: " + name.toStdString());
    }

    const auto val = json.value(name);

    return toObject(val);
}

int getValue(const QString& name, const QJsonObject& json)
{
    if(!json.contains(name))
    {
        throw std::runtime_error("Json object does not contain key: " + name.toStdString());
    }

    const auto val = json.value(name);

    if(!val.isDouble())
    {
        throw std::runtime_error(name.toStdString() + " is not double type.");
    }

    return static_cast<int>(val.toDouble()); // TODO
}

QString getString(const QString& name, const QJsonObject& json)
{
    if(!json.contains(name))
    {
        throw std::runtime_error("Json object does not contain key: " + name.toStdString());
    }

    const auto val = json.value(name);

    if(!val.isString())
    {
        throw std::runtime_error(name.toStdString() + " is not string type.");
    }

    return val.toString();
}

QStringList getPortraits(const QString& name)
{
    QStringList portraits;

    QDirIterator it(":/data/portraits", QDirIterator::Subdirectories);
    while (it.hasNext()) {
        const auto portrait = it.next();
        if(portrait.contains(name))
        {
            portraits.append(QUrl(portrait).fileName());
        }
    }

    std::sort(portraits.begin(), portraits.end());

    return portraits;
}

QJsonDocument loadJson(const QString path)
{
    QFile f(path);

    if (!f.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        throw std::runtime_error("Could not open file: " + path.toStdString());
    }

    QJsonParseError parseError;
    QJsonDocument jsonDoc = QJsonDocument::fromJson(f.readAll(), &parseError);

    if(parseError.error != QJsonParseError::NoError)
    {
        throw std::runtime_error(parseError.errorString().toStdString());
    }

    return jsonDoc;
}

QList<FETHClass*> loadClasses()
{
    const auto jsonDoc = loadJson(":/data/classes.json");

    const auto classesJson = jsonDoc.object();
    const QStringList classNames = classesJson.keys();

    QList<FETHClass*> feClasses;

    for(const auto& className : classNames)
    {
        const auto classJson = getObject(className, classesJson);
        const auto classType = getString("type", classJson);
        const auto growthRatesJson = getObject("growthRates", classJson);

        const int hp = getValue("hp", growthRatesJson);
        const int str = getValue("str", growthRatesJson);
        const int mag = getValue("mag", growthRatesJson);
        const int dex = getValue("dex", growthRatesJson);
        const int spd = getValue("spd", growthRatesJson);
        const int lck = getValue("lck", growthRatesJson);
        const int def = getValue("def", growthRatesJson);
        const int res = getValue("res", growthRatesJson);
        const int charm = getValue("charm", growthRatesJson);

        const auto growthRates = std::make_shared<FETHGrowthRates>(hp, str, mag, dex, spd, lck, def, res, charm);
        FETHClass* feClass = new FETHClass(className, classType, std::move(growthRates)); // TODO ochange ownership to delete later
        feClasses.append(feClass);
    }

    qDebug() << "Loaded" << feClasses.size() << "classes.";

    return feClasses;

}

QList<FETHCharacter*> loadCharacters()
{
    const auto jsonDoc = loadJson(":/data/characters.json");

    const auto charactersJson = jsonDoc.object();
    const QStringList characterNames = charactersJson.keys();

    QList<FETHCharacter*> feCharacters;

    for(const auto& charName : characterNames)
    {
        const auto charJson = getObject(charName, charactersJson);
        const auto house = getString("house", charJson);
        const auto growthRatesJson = getObject("growthRates", charJson);
        const auto portraits = getPortraits(charName);

        const int hp = getValue("hp", growthRatesJson);
        const int str = getValue("str", growthRatesJson);
        const int mag = getValue("mag", growthRatesJson);
        const int dex = getValue("dex", growthRatesJson);
        const int spd = getValue("spd", growthRatesJson);
        const int lck = getValue("lck", growthRatesJson);
        const int def = getValue("def", growthRatesJson);
        const int res = getValue("res", growthRatesJson);
        const int charm = getValue("charm", growthRatesJson);

        const auto growthRates = std::make_shared<FETHGrowthRates>(hp, str, mag, dex, spd, lck, def, res, charm);
        FETHCharacter* character = new FETHCharacter(charName, house, growthRates, portraits); // TODO ochange ownership to delete later
        feCharacters.append(character);
    }

    qDebug() << "Loaded" << feCharacters.size() << "characters.";

    return feCharacters;
}
