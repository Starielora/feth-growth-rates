#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QIcon>
#include <QList>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QList>
#include <QException>

#include "Character.h"
#include "FEClass.h"

#include <exception>

QJsonDocument loadJson(const QString path);
QList<Character*> loadCharacters();
QList<FEClass*> loadClasses();
template<class T>
void setParent(const QList<T>&, QObject* const);
FEClass* findClass(const QString&, const QList<FEClass*>&);
void setClass(const QList<Character*>&, FEClass* const);

int main(int argc, char *argv[]) try
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterUncreatableType<GrowthRates>("feth", 1, 0, "GrowthRates", "GrowthRates instances are provided by the application");
    qmlRegisterUncreatableType<Character>("feth", 1, 0, "Character", "Character instances are provided by the application");
    qmlRegisterUncreatableType<FEClass>("feth", 1, 0, "FEClass", "FEClass instance is provided by the application");

    const auto feClasses = loadClasses();
    const auto feCharacters = loadCharacters();

    setParent(feClasses, &app);
    setParent(feCharacters, &app);

    const auto baseClass = findClass("Base", feClasses);
    setClass(feCharacters, baseClass);

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

FEClass* findClass(const QString& name, const QList<FEClass*>& list)
{
    for(const auto& c : list)
    {
        if(c->getName() == name)
        {
            return c;
        }
    }

    throw std::runtime_error("Could not find class " + name.toStdString());
}

void setClass(const QList<Character*>& list, FEClass* const c)
{
    for(const auto& character : list)
    {
        character->setClass(c);
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

QList<FEClass*> loadClasses()
{
    const auto jsonDoc = loadJson(":/data/classes.json");

    const auto classesJson = jsonDoc.object();
    const QStringList classNames = classesJson.keys();

    QList<FEClass*> feClasses;

    for(const auto& className : classNames)
    {
        const auto classJson = getObject(className, classesJson);
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

        const data::GrowthRates growthRates{hp, str, mag, dex, spd, lck, def, res, charm};

        FEClass* feClass = new FEClass(className, growthRates); // TODO ochange ownership to delete later
        feClasses.append(feClass);
    }

    qDebug() << "Loaded" << feClasses.size() << "classes.";

    return feClasses;

}

QList<Character*> loadCharacters()
{
    const auto jsonDoc = loadJson(":/data/characters.json");

    const auto charactersJson = jsonDoc.object();
    const QStringList characterNames = charactersJson.keys();

    QList<Character*> feCharacters;

    for(const auto& charName : characterNames)
    {
        const auto charJson = getObject(charName, charactersJson);
        const auto growthRatesJson = getObject("growthRates", charJson);

        const int hp = getValue("hp", growthRatesJson);
        const int str = getValue("str", growthRatesJson);
        const int mag = getValue("mag", growthRatesJson);
        const int dex = getValue("dex", growthRatesJson);
        const int spd = getValue("spd", growthRatesJson);
        const int lck = getValue("lck", growthRatesJson);
        const int def = getValue("def", growthRatesJson);
        const int res = getValue("res", growthRatesJson);
        const int charm = getValue("charm", growthRatesJson);

        const data::GrowthRates growthRates{hp, str, mag, dex, spd, lck, def, res, charm};

        Character* character = new Character(charName, growthRates); // TODO ochange ownership to delete later
        feCharacters.append(character);
    }

    qDebug() << "Loaded" << feCharacters.size() << "characters.";

    return feCharacters;
}
