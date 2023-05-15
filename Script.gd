extends Node

# Propiedades
var quacks = 0
var users = 1
var quacksPerUser = 1
var currentUpgradeLevel = 1

# Constantes
const QUACKSCRIPT_COST = 100000000
const MAX_DAYS = 1095
const CONSUME_TIME_MIN = 5
const CONSUME_TIME_MAX = 10
const USERS_INFLATION_RATE = 0.1

var currentDays = 0
var consumeTime = 0

# Diccionario de mejoras de lenguaje
var languageUpgrades = {
    1: "Java",
    2: "JavaScript",
    3: "Python",
    4: "TypeScript",
    5: "QuackScript"
}

func _process(delta):
    generateResources(delta)
    checkGameEnd()
    consumeResources(delta)
    adjustResourceGeneration()

func generateResources(delta):
    # Generación de quacks por los usuarios
    var generatedQuacks = users * quacksPerUser * delta
    quacks += generatedQuacks

func checkGameEnd():
    currentDays += 1

    # Verificar si se alcanzó la cantidad requerida de quacks
    if quacks >= QUACKSCRIPT_COST:
        gameWon()

    # Verificar si se alcanzó el límite de días
    if currentDays > MAX_DAYS:
        gameOver()

func consumeResources(delta):
    consumeTime += delta

    if consumeTime >= CONSUME_TIME_MIN and consumeTime <= CONSUME_TIME_MAX:
        var consumedQuacks = quacks * delta
        quacks -= consumedQuacks

func adjustResourceGeneration():
    # Ajustar la generación de usuarios en función del tiempo transcurrido
    users += users * USERS_INFLATION_RATE * delta

func buyUpgrade():
    var upgradeCost = 1000000 * currentUpgradeLevel

    if quacks >= upgradeCost:
        quacks -= upgradeCost
        upgradeLanguage()
        print("¡Has comprado la mejora de nivel " + str(currentUpgradeLevel) + ": " + languageUpgrades[currentUpgradeLevel] + "!")
    else:
        print("No tienes suficientes quacks para comprar la mejora de nivel " + str(currentUpgradeLevel) + ".")

func upgradeLanguage():
    if currentUpgradeLevel < 5:
        currentUpgradeLevel += 1
    else:
        print("¡Ya has alcanzado el nivel máximo de mejora!")

func gameWon():
    print("¡Quack! Has lanzado QuackScript. ¡Has ganado el juego!")

func gameOver():
    print("¡Recórcholis! Tus seguidores se cansaron de esperar que termines un proyecto. ¡Has perdido!")

