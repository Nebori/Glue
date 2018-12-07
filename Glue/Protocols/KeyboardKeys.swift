//
//  KeyboardKeys.swift
//  Glue
//
//  Created by 김인중 on 07/12/2018.
//  Copyright © 2018 nebori92. All rights reserved.
//

import Cocoa

enum KeyboardKeys {
    // Main keys
    //      1 line
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case zero
    case minus
    case equal
    case delete
    //      2 line
    case q
    case w
    case e
    case r
    case t
    case y
    case u
    case i
    case o
    case p
    case openBracket
    case closeBracket
    case pipe
    //      3 line
    case a
    case s
    case d
    case f
    case g
    case h
    case j
    case k
    case l
    case semicolon
    case quote
    case enter
    //      4 line
    case z
    case x
    case c
    case v
    case b
    case n
    case m
    case lessThan
    case greaterThan
    case slash
    
    // Number pad
    case numlockOne
    case numlockTwo
    case numlockThree
    case numlockFour
    case numlockFive
    case numlockSix
    case numlockSeven
    case numlockEight
    case numlockNine
    case numlockZero
    case numlockClear
    case numlockEqual
    case numlockSlash
    case numlockAsterisk
    case numlockMinus
    case numlockPlus
    case numlockEnter
    case numlockDot
    
    // method
    case fn
    case home
    case methodDelete
    case end
    case pageUp
    case pageDown
    
    // arrow
    case up
    case down
    case right
    case left
    
    // function
    case esc
    case f1
    case f2
    case f3
    case f4
    case f5
    case f6
    case f7
    case f8
    case f9
    case f10
    case f11
    case f12
    case f13
    case f14
    case f15
    
    // unknown
    case unknown
}

struct KeyboardKey {
    private var key: KeyboardKeys
    init(_ key: KeyboardKeys) {
        self.key = key
    }
    init(_ strKey: String) {
        switch strKey {
        // 1 line
        case "1", "!":
            self.key = .one
        case "2", "@":
            self.key = .two
        case "3", "#":
            self.key = .three
        case "4", "$":
            self.key = .four
        case "5", "%":
            self.key = .five
        case "6", "^":
            self.key = .six
        case "7", "&":
            self.key = .seven
        case "8", "*":
            self.key = .eight
        case "9", "(":
            self.key = .nine
        case "0", ")":
            self.key = .zero
        case "-", "_":
            self.key = .minus
        case "=", "+":
            self.key = .equal
        case "delete":
            self.key = .delete
        // 2 line
        case "q":
            self.key = .q
        case "w":
            self.key = .w
        case "e":
            self.key = .e
        case "r":
            self.key = .r
        case "t":
            self.key = .t
        case "y":
            self.key = .y
        case "u":
            self.key = .u
        case "i":
            self.key = .i
        case "o":
            self.key = .o
        case "p":
            self.key = .p
        case "[", "{":
            self.key = .openBracket
        case "]", "}":
            self.key = .closeBracket
        case "\\", "|":
            self.key = .pipe
        // 3 line
        case "a":
            self.key = .a
        case "s":
            self.key = .s
        case "d":
            self.key = .d
        case "f":
            self.key = .f
        case "g":
            self.key = .g
        case "h":
            self.key = .h
        case "j":
            self.key = .j
        case "k":
            self.key = .k
        case "l":
            self.key = .l
        case ";", ":":
            self.key = .semicolon
        case "'", "\"":
            self.key = .quote
        case "\n":
            self.key = .enter
        // 4 lien
        case "z":
            self.key = .z
        case "x":
            self.key = .x
        case "c":
            self.key = .c
        case "v":
            self.key = .v
        case "b":
            self.key = .b
        case "n":
            self.key = .n
        case "m":
            self.key = .m
        case ",", "<":
            self.key = .lessThan
        case ".", ">":
            self.key = .greaterThan
        case "/", "?":
            self.key = .slash
        // Number pad
        case "clear":
            self.key = .numlockClear
        // method
        case "fn":
            self.key = .fn
        case "home":
            self.key = .home
        case "end":
            self.key = .end
        case "pageUp":
            self.key = .pageUp
        case "pageDown":
            self.key = .pageDown
        // arrow
        case "up":
            self.key = .up
        case "down":
            self.key = .down
        case "right":
            self.key = .right
        case "left":
            self.key = .left
        // function
        case "esc":
            self.key = .esc
        case "f1":
            self.key = .f1
        case "f2":
            self.key = .f2
        case "f3":
            self.key = .f3
        case "f4":
            self.key = .f4
        case "f5":
            self.key = .f5
        case "f6":
            self.key = .f6
        case "f7":
            self.key = .f7
        case "f8":
            self.key = .f8
        case "f9":
            self.key = .f9
        case "f10":
            self.key = .f10
        case "f11":
            self.key = .f11
        case "f12":
            self.key = .f12
        case "f13":
            self.key = .f13
        case "f14":
            self.key = .f14
        case "f15":
            self.key = .f15
        default:
            self.key = .unknown
        }
    }
    init(_ intKey: UInt16) {
        switch intKey {
        // 1 line
        case 18:
            self.key = .one
        case 19:
            self.key = .two
        case 20:
            self.key = .three
        case 21:
            self.key = .four
        case 23:
            self.key = .five
        case 22:
            self.key = .six
        case 26:
            self.key = .seven
        case 28:
            self.key = .eight
        case 25:
            self.key = .nine
        case 29:
            self.key = .zero
        case 27:
            self.key = .minus
        case 24:
            self.key = .equal
        case 51:
            self.key = .delete
        // 2 line
        case 12:
            self.key = .q
        case 13:
            self.key = .w
        case 14:
            self.key = .e
        case 15:
            self.key = .r
        case 17:
            self.key = .t
        case 16:
            self.key = .y
        case 32:
            self.key = .u
        case 34:
            self.key = .i
        case 31:
            self.key = .o
        case 35:
            self.key = .p
        case 33:
            self.key = .openBracket
        case 30:
            self.key = .closeBracket
        case 42:
            self.key = .pipe
        // 3 line
        case 0:
            self.key = .a
        case 1:
            self.key = .s
        case 2:
            self.key = .d
        case 3:
            self.key = .f
        case 5:
            self.key = .g
        case 4:
            self.key = .h
        case 38:
            self.key = .j
        case 40:
            self.key = .k
        case 37:
            self.key = .l
        case 41:
            self.key = .semicolon
        case 39:
            self.key = .quote
        case 36:
            self.key = .enter
        // 4 lien
        case 6:
            self.key = .z
        case 7:
            self.key = .x
        case 8:
            self.key = .c
        case 9:
            self.key = .v
        case 11:
            self.key = .b
        case 45:
            self.key = .n
        case 46:
            self.key = .m
        case 43:
            self.key = .lessThan
        case 47:
            self.key = .greaterThan
        case 44:
            self.key = .slash
        // Number pad
        case 83:
            self.key = .numlockOne
        case 84:
            self.key = .numlockTwo
        case 85:
            self.key = .numlockThree
        case 86:
            self.key = .numlockFour
        case 87:
            self.key = .numlockFive
        case 88:
            self.key = .numlockSix
        case 89:
            self.key = .numlockSeven
        case 91:
            self.key = .numlockEight
        case 92:
            self.key = .numlockNine
        case 82:
            self.key = .numlockZero
        case 71:
            self.key = .numlockClear
        case 81:
            self.key = .numlockEqual
        case 75:
            self.key = .numlockSlash
        case 67:
            self.key = .numlockAsterisk
        case 78:
            self.key = .numlockMinus
        case 69:
            self.key = .numlockPlus
        case 76:
            self.key = .numlockEnter
        case 65:
            self.key = .numlockDot
        // method
        case 144:
            self.key = .fn
        case 115:
            self.key = .home
        case 119:
            self.key = .end
        case 116:
            self.key = .pageUp
        case 121:
            self.key = .pageDown
        case 117:
            self.key = .methodDelete
        // arrow
        case 126:
            self.key = .up
        case 125:
            self.key = .down
        case 124:
            self.key = .right
        case 123:
            self.key = .left
        // function
        case 53:
            self.key = .esc
        case 122:
            self.key = .f1
        case 120:
            self.key = .f2
        case 99:
            self.key = .f3
        case 118:
            self.key = .f4
        case 96:
            self.key = .f5
        case 97:
            self.key = .f6
        case 98:
            self.key = .f7
        case 100:
            self.key = .f8
        case 101:
            self.key = .f9
        case 109:
            self.key = .f10
        case 103:
            self.key = .f11
        case 111:
            self.key = .f12
        case 105:
            self.key = .f13
        case 107:
            self.key = .f14
        case 113:
            self.key = .f15
        default:
            self.key = .unknown
        }
    }
    func getKey() -> KeyboardKeys {
        return key
    }
    func getString() -> String {
        var str = "unknown"
        switch key {
        // 1 line
        case .one, .numlockOne:
            str = "1"
        case .two, .numlockTwo:
            str = "2"
        case .three, .numlockThree:
            str = "3"
        case .four, .numlockFour:
            str = "4"
        case .five, .numlockFive:
            str = "5"
        case .six, .numlockSix:
            str = "6"
        case .seven, .numlockSeven:
            str = "7"
        case .eight, .numlockEight:
            str = "8"
        case .nine, .numlockNine:
            str = "9"
        case .zero, .numlockZero:
            str = "0"
        case .minus, .numlockMinus:
            str = "-"
        case .equal, .numlockEqual:
            str = "="
        case .delete, .methodDelete:
            str = "delete"
        // 2 line
        case .q:
            str = "q"
        case .w:
            str = "w"
        case .e:
            str = "e"
        case .r:
            str = "r"
        case .t:
            str = "t"
        case .y:
            str = "y"
        case .u:
            str = "u"
        case .i:
            str = "i"
        case .o:
            str = "o"
        case .p:
            str = "p"
        case .openBracket:
            str = "["
        case .closeBracket:
            str = "]"
        case .pipe:
            str = "\\"
        // 3 line
        case .a:
            str = "a"
        case .s:
            str = "s"
        case .d:
            str = "d"
        case .f:
            str = "f"
        case .g:
            str = "g"
        case .h:
            str = "h"
        case .j:
            str = "j"
        case .k:
            str = "k"
        case .l:
            str = "l"
        case .semicolon:
            str = ";"
        case .quote:
            str = "'"
        case .enter, .numlockEnter:
            str = "\n"
        // 4 lien
        case .z:
            str = "z"
        case .x:
            str = "x"
        case .c:
            str = "c"
        case .v:
            str = "v"
        case .b:
            str = "b"
        case .n:
            str = "n"
        case .m:
            str = "m"
        case .lessThan:
            str = ","
        case .greaterThan, .numlockDot:
            str = "."
        case .slash:
            str = "/"
        // Number pad
        case .numlockClear:
            str = "clear"
        // method
        case .fn:
            str = "fn"
        case .home:
            str = "home"
        case .end:
            str = "end"
        case .pageUp:
            str = "pageUp"
        case .pageDown:
            str = "pageDown"
        // arrow
        case .up:
            str = "up"
        case .down:
            str = "down"
        case .right:
            str = "right"
        case .left:
            str = "left"
        // function
        case .esc:
            str = "esc"
        case .f1:
            str = "f1"
        case .f2:
            str = "f2"
        case .f3:
            str = "f3"
        case .f4:
            str = "f4"
        case .f5:
            str = "f5"
        case .f6:
            str = "f6"
        case .f7:
            str = "f7"
        case .f8:
            str = "f8"
        case .f9:
            str = "f9"
        case .f10:
            str = "f10"
        case .f11:
            str = "f11"
        case .f12:
            str = "f12"
        case .f13:
            str = "f13"
        case .f14:
            str = "f14"
        case .f15:
            str = "f15"
        default:
            str = "unknown"
        }
        return str
    }
    func getUInt16() -> UInt16 {
        var uint: UInt16 = 0
        switch key {
        // 1 line
        case .one:
            uint = 18
        case .two:
            uint = 19
        case .three:
            uint = 20
        case .four:
            uint = 21
        case .five:
            uint = 23
        case .six:
            uint = 22
        case .seven:
            uint = 26
        case .eight:
            uint = 28
        case .nine:
            uint = 25
        case .zero:
            uint = 29
        case .minus:
            uint = 27
        case .equal:
            uint = 24
        case .delete:
            uint = 51
        // 2 line
        case .q:
            uint = 12
        case .w:
            uint = 13
        case .e:
            uint = 14
        case .r:
            uint = 15
        case .t:
            uint = 17
        case .y:
            uint = 16
        case .u:
            uint = 32
        case .i:
            uint = 34
        case .o:
            uint = 31
        case .p:
            uint = 35
        case .openBracket:
            uint = 33
        case .closeBracket:
            uint = 30
        case .pipe:
            uint = 42
        // 3 line
        case .a:
            uint = 0
        case .s:
            uint = 1
        case .d:
            uint = 2
        case .f:
            uint = 3
        case .g:
            uint = 5
        case .h:
            uint = 4
        case .j:
            uint = 38
        case .k:
            uint = 40
        case .l:
            uint = 37
        case .semicolon:
            uint = 41
        case .quote:
            uint = 39
        case .enter:
            uint = 36
        // 4 lien
        case .z:
            uint = 6
        case .x:
            uint = 7
        case .c:
            uint = 8
        case .v:
            uint = 9
        case .b:
            uint = 11
        case .n:
            uint = 45
        case .m:
            uint = 46
        case .lessThan:
            uint = 43
        case .greaterThan:
            uint = 47
        case .slash:
            uint = 44
        // Number pad
        case .numlockOne:
            uint = 83
        case .numlockTwo:
            uint = 84
        case .numlockThree:
            uint = 85
        case .numlockFour:
            uint = 86
        case .numlockFive:
            uint = 87
        case .numlockSix:
            uint = 88
        case .numlockSeven:
            uint = 89
        case .numlockEight:
            uint = 91
        case .numlockNine:
            uint = 92
        case .numlockZero:
            uint = 82
        case .numlockClear:
            uint = 71
        case .numlockEqual:
            uint = 81
        case .numlockSlash:
            uint = 75
        case .numlockAsterisk:
            uint = 67
        case .numlockMinus:
            uint = 78
        case .numlockPlus:
            uint = 69
        case .numlockEnter:
            uint = 76
        case .numlockDot:
            uint = 65
        // method
        case .fn:
            uint = 114
        case .home:
            uint = 115
        case .pageUp:
            uint = 116
        case .methodDelete:
            uint = 117
        case .end:
            uint = 119
        case .pageDown:
            uint = 121
        // arrow
        case .up:
            uint = 126
        case .down:
            uint = 125
        case .right:
            uint = 124
        case .left:
            uint = 123
        // function
        case .esc:
            uint = 53
        case .f1:
            uint = 122
        case .f2:
            uint = 120
        case .f3:
            uint = 99
        case .f4:
            uint = 118
        case .f5:
            uint = 96
        case .f6:
            uint = 97
        case .f7:
            uint = 98
        case .f8:
            uint = 100
        case .f9:
            uint = 101
        case .f10:
            uint = 109
        case .f11:
            uint = 103
        case .f12:
            uint = 111
        case .f13:
            uint = 105
        case .f14:
            uint = 107
        case .f15:
            uint = 113
        default:
            uint = 1000
        }
        return uint
    }
}
