//: Playground - noun: a place where people can play

import UIKit


/**============================================================================================================================================================================================
 
 **============================================================================================================================================================================================
 **============================================================================================================================================================================================
 **============================================================================================================================================================================================
 **============================================================================================================================================================================================
 **============================================================================================================================================================================================
 */

//
//For-In 循环
//While 循环
//条件语句
//控制转移语句（Control Transfer Statements）
//提前退出
//检测 API 可用性
//

/** For-In 循环 */
//你可以使用 for-in 循环来遍历一个集合中的所有元素，例如数组中的元素、数字范围或者字符串中的字符。
//以下例子使用 for-in 遍历一个数组所有元素：

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!

//你也可以通过遍历一个字典来访问它的键值对。遍历字典时，字典的每项元素会以 (key, value) 元组的形式返回，你可以在 for-in 循环中使用显式的常量名称来解读 (key, value) 元组。下面的例子中，字典的键解读为常量 animalName，字典的值会被解读为常量 legCount：


let numberOfLegs = ["spider": 8, "ant": 6, "cat" :4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// ants have 6 legs
// spiders have 8 legs
// cats have 4 legs

/***
 字典的内容本质上是无序的，遍历元素时不能保证顺序。特别地，将元素插入一个字典的顺序并不会决定它们被遍历的顺序。关于数组和字典，详情参见集合类型。
 
 for-in 循环还可以使用数字范围。下面的例子用来输出乘 5 乘法表前面一部分内容：
 
 */
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
/**
例子中用来进行遍历的元素是使用闭区间操作符（...）表示的从 1 到 5 的数字区间。index 被赋值为闭区间中的第一个数字（1），然后循环中的语句被执行一次。在本例中，这个循环只包含一个语句，用来输出当前 index 值所对应的乘 5 乘法表的结果。该语句执行后，index 的值被更新为闭区间中的第二个数字（2），之后 print(_:separator:terminator:) 函数会再执行一次。整个过程会进行到闭区间结尾为止。

上面的例子中，index 是一个每次循环遍历开始时被自动赋值的常量。这种情况下，index 在使用前不需要声明，只需要将它包含在循环的声明中，就可以对其进行隐式声明，而无需使用 let 关键字声明。
    
如果你不需要区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略这个值：
*/

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// 输出 "3 to the power of 10 is 59049"
/**
这个例子计算 base 这个数的 power 次幂（本例中，是 3 的 10 次幂），从 1（ 3 的 0 次幂）开始做 3 的乘法， 进行 10 次，使用 1 到 10 的闭区间循环。这个计算并不需要知道每一次循环中计数器具体的值，只需要执行了正确的循环次数即可。下划线符号 _ （替代循环中的变量）能够忽略当前值，并且不提供循环遍历时对值的访问。

在某些情况下，你可能不想使用闭区间，包括两个端点。在一个手表上每分钟绘制一个刻度线。要绘制 60 个刻度，从 0 分钟开始。使用半开区间运算符（..<）来包含下限，但不包括上限。

*/

let minutes = 60
for tickMark in 0..<minutes{
    // 每1分钟呈现一个刻度线（60次）
}
//一些用户可能在其UI中可能需要较少的刻度。他们可以每5分钟作为一个刻度。使用 stride(from:to:by:) 函数跳过不需要的标记。
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // 每5分钟呈现一个刻度线 (0, 5, 10, 15 ... 45, 50, 55)
}
//可以在闭区间使用 stride(from:through:by:) 起到同样作用：
let hours = 12
let hoursInterval = 3
for tickMark in stride(from: 3, through: hours, by: hoursInterval) {
    // 每3小时呈现一个刻度线 (3, 6, 9, 12)
}

/** While 循环 */
//while循环会一直运行一段语句直到条件变成false。这类循环适合使用在第一次迭代前，迭代次数未知的情况下。Swift 提供两种while循环形式：

/**
while循环，每次在循环开始时计算条件是否符合；
repeat-while循环，每次在循环结束时计算条件是否符合。

While
while循环从计算一个条件开始。如果条件为true，会重复运行一段语句，直到条件变为false。
*/
//下面的例子来玩一个叫做蛇和梯子（也叫做滑道和梯子）的小游戏：

/**
游戏的规则如下：

游戏盘面包括 25 个方格，游戏目标是达到或者超过第 25 个方格；
每一轮，你通过掷一个六面体骰子来确定你移动方块的步数，移动的路线由上图中横向的虚线所示；
如果在某轮结束，你移动到了梯子的底部，可以顺着梯子爬上去；
如果在某轮结束，你移动到了蛇的头部，你会顺着蛇的身体滑下去。
游戏盘面可以使用一个Int数组来表达。数组的长度由一个finalSquare常量储存，用来初始化数组和检测最终胜利条件。游戏盘面由 26 个 Int 0 值初始化，而不是 25 个（由0到25，一共 26 个）：
*/
/**
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
//一些方格被设置成特定的值来表示有蛇或者梯子。梯子底部的方格是一个正值，使你可以向上移动，蛇头处的方格是一个负值，会让你向下移动：

board[03] = +08;
board[06] = +11;
board[09] = +09;
board[10] = +02
board[14] = -10;
board[19] = -11;
board[22] = -02;
board[24] = -08
*/

//玩家由左下角空白处编号为 0 的方格开始游戏。玩家第一次掷骰子后才会进入游戏盘面：
/**
var square = 0
var diceRoll = 0
while square < finalSquare {
    //投色子
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
    }
    //根据点数移动
    square += diceRoll
    if square < board.count {
        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
}
print("Game over!")
*/

//本例中使用了最简单的方法来模拟掷骰子。 diceRoll的值并不是一个随机数，而是以0为初始值，之后每一次while循环，diceRoll的值增加 1 ，然后检测是否超出了最大值。当diceRoll的值等于 7 时，就超过了骰子的最大值，会被重置为1。所以diceRoll的取值顺序会一直是 1 ，2，3，4，5，6，1，2 等。

//掷完骰子后，玩家向前移动diceRoll个方格，如果玩家移动超过了第 25 个方格，这个时候游戏将会结束，为了应对这种情况，代码会首先判断square的值是否小于board的count属性，只有小于才会在board[square]上增加square，来向前或向后移动（遇到了梯子或者蛇）。
/**
注意：
如果没有这个检测（square < board.count），board[square]可能会越界访问board数组，导致错误。如果square等于26， 代码会去尝试访问board[26]，超过数组的长度。

当本轮while循环运行完毕，会再检测循环条件是否需要再运行一次循环。如果玩家移动到或者超过第 25 个方格，循环条件结果为false，此时游戏结束。

while 循环比较适合本例中的这种情况，因为在 while 循环开始时，我们并不知道游戏要跑多久，只有在达成指定条件时循环才会结束。

*/
/** Repeat-While */
//while循环的另外一种形式是repeat-while，它和while的区别是在判断循环条件之前，先执行一次循环的代码块。然后重复循环直到条件为false。
/**
注意：
Swift语言的repeat-while循环和其他语言中的do-while循环是类似的。
*/

//下面是 repeat-while循环的一般格式：
/**
repeat {
    statements
} while condition
*/

//还是蛇和梯子的游戏，使用repeat-while循环来替代while循环。finalSquare、board、square和diceRoll的值初始化同while循环时一样：
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

//repeat-while的循环版本，循环中第一步就需要去检测是否在梯子或者蛇的方块上。没有梯子会让玩家直接上到第 25 个方格，所以玩家不会通过梯子直接赢得游戏。这样在循环开始时先检测是否踩在梯子或者蛇上是安全的。

//游戏开始时，玩家在第 0 个方格上，board[0]一直等于 0， 不会有什么影响：

repeat {
    // 顺着梯子爬上去或者顺着蛇滑下去
    square += board[square]
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // 根据点数移动
    square += diceRoll
} while square < finalSquare
print("Game over!")

/**
 检测完玩家是否踩在梯子或者蛇上之后，开始掷骰子，然后玩家向前移动diceRoll个方格，本轮循环结束。
 
 循环条件（while square < finalSquare）和while方式相同，但是只会在循环结束后进行计算。在这个游戏中，repeat-while表现得比while循环更好。repeat-while方式会在条件判断square没有超出后直接运行square += board[square]，这种方式可以去掉while版本中的数组越界判断。
 */
/** 条件语句 */
//根据特定的条件执行特定的代码通常是十分有用的。当错误发生时，你可能想运行额外的代码；或者，当值太大或太小时，向用户显示一条消息。要实现这些功能，你就需要使用条件语句。

//Swift 提供两种类型的条件语句：if语句和switch语句。通常，当条件较为简单且可能的情况很少时，使用if语句。而switch语句更适用于条件较复杂、有更多排列组合的时候。并且switch在需要用到模式匹配（pattern-matching）的情况下会更有用。
/**
If
if语句最简单的形式就是只包含一个条件，只有该条件为true时，才执行相关代码：
 */

var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// 输出 "It's very cold. Consider wearing a scarf."

//上面的例子会判断温度是否小于等于 32 华氏度（水的冰点）。如果是，则打印一条消息；否则，不打印任何消息，继续执行if块后面的代码。
//当然，if语句允许二选一执行，叫做else从句。也就是当条件为false时，执行 else 语句：

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// 输出 "It's not that cold. Wear a t-shirt."
//显然，这两条分支中总有一条会被执行。由于温度已升至 40 华氏度，不算太冷，没必要再围围巾。因此，else分支就被触发了。
//你可以把多个if语句链接在一起，来实现更多分支：
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// 输出 "It's really warm. Don't forget to wear sunscreen."

//在上面的例子中，额外的if语句用于判断是不是特别热。而最后的else语句被保留了下来，用于打印既不冷也不热时的消息。
//实际上，当不需要完整判断情况的时候，最后的else语句是可选的：
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}
//在这个例子中，由于既不冷也不热，所以不会触发if或else if分支，也就不会打印任何消息。


/** Switch */
//switch语句会尝试把某个值与若干个模式（pattern）进行匹配。根据第一个匹配成功的模式，switch语句会执行对应的代码。当有可能的情况较多时，通常用switch语句替换if语句。

//switch语句最简单的形式就是把某个值与一个或若干个相同类型的值作比较：
/**
switch some value to consider {
    case value 1:
    respond to value 1
    case value 2,
    value 3:
    respond to value 2 or 3
    default:
    otherwise, do something else
}
*/

//switch语句由多个 case 构成，每个由case关键字开始。为了匹配某些更特定的值，Swift 提供了几种方法来进行更复杂的模式匹配，这些模式将在本节的稍后部分提到。

//与if语句类似，每一个 case 都是代码执行的一条分支。switch语句会决定哪一条分支应该被执行，这个流程被称作根据给定的值切换(switching)。

//switch语句必须是完备的。这就是说，每一个可能的值都必须至少有一个 case 分支与之对应。在某些不可能涵盖所有值的情况下，你可以使用默认（default）分支来涵盖其它所有没有对应的值，这个默认分支必须在switch语句的最后面。

//下面的例子使用switch语句来匹配一个名为someCharacter的小写字符：

let someCharacter: Character = "2"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}
// 输出 "The last letter of the alphabet"

/**
 在这个例子中，第一个 case 分支用于匹配第一个英文字母a，第二个 case 分支用于匹配最后一个字母z。 因为switch语句必须有一个case分支用于覆盖所有可能的字符，而不仅仅是所有的英文字母，所以switch语句使用default分支来匹配除了a和z外的所有值，这个分支保证了swith语句的完备性。
 */


/**不存在隐式的贯穿*/

/**

 与 C 和 Objective-C 中的switch语句不同，在 Swift 中，当匹配的 case 分支中的代码执行完毕后，程序会终止switch语句，而不会继续执行下一个 case 分支。这也就是说，不需要在 case 分支中显式地使用break语句。这使得switch语句更安全、更易用，也避免了因忘记写break语句而产生的错误。
 每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的，因为第一个 case 分支是空的：
 */


/**
 let anotherCharacter: Character = "a"
 switch anotherCharacter {
 case "a": // 无效，这个分支下面没有语句
 case "A":
 print("The letter A")
 default:
 print("Not the letter A")
 }
 // 这段代码会报编译错误
 **/

/**
 不像 C 语言里的switch语句，在 Swift 中，switch语句不会一起匹配"a"和"A"。相反的，上面的代码会引起编译期错误：case "a": 不包含任何可执行语句——这就避免了意外地从一个 case 分支贯穿到另外一个，使得代码更安全、也更直观。
 
 为了让单个case同时匹配a和A，可以将这个两个值组合成一个复合匹配，并且用逗号分开：
 **/

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// 输出 "The letter A

/**
 区间匹配
 case 分支的模式也可以是一个值的区间。下面的例子展示了如何使用区间匹配来输出任意数字对应的自然语言格式：
 */

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// 输出 "There are dozens of moons orbiting Saturn."

/**
 在上例中，approximateCount在一个switch声明中被评估。每一个case都与之进行比较。因为approximateCount落在了 12 到 100 的区间，所以naturalCount等于"dozens of"值，并且此后的执行跳出了switch语句。
 */

/**
 元组
 我们可以使用元组在同一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
 
 下面的例子展示了如何使用一个(Int, Int)类型的元组来分类下图中的点(x, y)：
 */

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
// 输出 "(1, 1) is inside the box"

/**
 在上面的例子中，switch语句会判断某个点是否是原点(0, 0)，是否在红色的x轴上，是否在橘黄色的y轴上，是否在一个以原点为中心的4x4的蓝色矩形里，或者在这个矩形外面。
 
 不像 C 语言，Swift 允许多个 case 匹配同一个值。实际上，在这个例子中，点(0, 0)可以匹配所有四个 case。但是，如果存在多个匹配，那么只会执行第一个被匹配到的 case 分支。考虑点(0, 0)会首先匹配case (0, 0)，因此剩下的能够匹配的分支都会被忽视掉。
 */


/**
 值绑定（Value Bindings）
 case 分支允许将匹配的值绑定到一个临时的常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑定（value binding），因为匹配的值在case分支体内，与临时的常量或变量绑定。
 
 下面的例子展示了如何在一个(Int, Int)类型的元组中使用值绑定来分类下图中的点(x, y)：
 */

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// 输出 "on the x-axis with an x value of 2"

/**
 在上面的例子中，switch语句会判断某个点是否在红色的x轴上，是否在橘黄色的y轴上，或者不在坐标轴上。
 
 这三个 case 都声明了常量x和y的占位符，用于临时获取元组anotherPoint的一个或两个值。第一个 case ——case (let x, 0)将匹配一个纵坐标为0的点，并把这个点的横坐标赋给临时的常量x。类似的，第二个 case ——case (0, let y)将匹配一个横坐标为0的点，并把这个点的纵坐标赋给临时的常量y。
 
 一旦声明了这些临时的常量，它们就可以在其对应的 case 分支里使用。在这个例子中，它们用于打印给定点的类型。
 
 请注意，这个switch语句不包含默认分支。这是因为最后一个 case ——case let(x, y)声明了一个可以匹配余下所有值的元组。这使得switch语句已经完备了，因此不需要再书写默认分支。
 */

/**
 Where
 case 分支的模式可以使用where语句来判断额外的条件。
 
 下面的例子把下图中的点(x, y)进行了分类：
 */

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// 输出 "(1, -1) is on the line x == -y"

/**
 在上面的例子中，switch语句会判断某个点是否在绿色的对角线x == y上，是否在紫色的对角线x == -y上，或者不在对角线上。
 
 这三个 case 都声明了常量x和y的占位符，用于临时获取元组yetAnotherPoint的两个值。这两个常量被用作where语句的一部分，从而创建一个动态的过滤器(filter)。当且仅当where语句的条件为true时，匹配到的 case 分支才会被执行。
 
 就像是值绑定中的例子，由于最后一个 case 分支匹配了余下所有可能的值，switch语句就已经完备了，因此不需要再书写默认分支。
 */

/**
 复合匹配
 当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个case后面，并且用逗号隔开。当case后面的任意一种模式匹配的时候，这条分支就会被匹配。并且，如果匹配列表过长，还可以分行书写：
 */


