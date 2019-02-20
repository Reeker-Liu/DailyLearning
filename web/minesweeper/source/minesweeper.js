var timeHandler = null;
var beginTime = null;   //每局的开始计时


var timeNum = null;
var mineNum = null;
var blockCount = 0;//地雷个数
var markedCount = 0;
var mineArr = new Array(10);   //10*10数组
var table = null;//画格子的表格

function init(){
    document.oncontextmenu = function () {//禁用右键菜单
        return false;
    };
    mineNum = document.getElementById("mineNum");
    timeNum = document.getElementById("timeNum");
    table = document.getElementById("mineArea");

    drawMap();
}

function restart() {
    clearInterval(timeHandler);
    drawMap();
}

function drawMap() {
    //设置初始值
    timeNum.innerHTML = 0;
    mineNum.innerHTML = 15;
    blockCount = 0;
    markedCount = 15;
    var i = 0;
    var j = 0;
    for (i = 0; i < 10; i++) {
        mineArr[i] = [];
        for (j = 0; j < 10; j++) {
            mineArr[i][j] = 0;
        }
    }

    //填充table内容
    var tds = [];
    for (i = 0; i < 10; i++) {
        tds.push("<tr>");
        for (j = 0; j < 10; j++) {
            tds.push("<td id='m_" + i + "_" + j + "'></td>");
        }
        tds.push("</td>");
    }
    table.innerHTML = tds.join("");

    //随机设置地雷位置

    var tempArr = {};
    for (i = 0; i < 15; i++){
        var temp = Math.floor(Math.random()*100);
        if(temp in tempArr){
            i--;
            continue;
        }
        mineArr[Math.floor(temp/10)][temp%10] = 9;
        tempArr[temp] = temp;
        //alert(Math.floor(temp/10) + " " + temp%10 + " is " + temp);
    }

    //计算其他格子中的数字
    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            if (mineArr[i][j] == 9)
                continue;
            if (i > 0 && j > 0) {
                if (mineArr[i - 1][j - 1] == 9)
                    mineArr[i][j]++;
            }
            if (i > 0) {
                if (mineArr[i - 1][j] == 9)
                    mineArr[i][j]++;
            }
            if (i > 0 && j < 9) {
                if (mineArr[i - 1][j + 1] == 9)
                    mineArr[i][j]++;
            }
            if (j > 0) {
                if (mineArr[i][j - 1] == 9)
                    mineArr[i][j]++;
            }
            if (j < 9) {
                if (mineArr[i][j + 1] == 9)
                    mineArr[i][j]++;
            }
            if (i < 9 && j > 0) {
                if (mineArr[i + 1][j - 1] == 9)
                    mineArr[i][j]++;
            }
            if (i < 9) {
                if (mineArr[i + 1][j] == 9)
                    mineArr[i][j]++;
            }
            if (i < 9 && j < 9) {
                if (mineArr[i + 1][j + 1] == 9)
                    mineArr[i][j]++;
            }
        }
    }
    //alert(mineArr);

    //给每个格子绑定点击事件（左键和右键）
    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            bind(i,j);
        }
    }

    //设置开始时间并开始计时
    beginTime = new Date();
    timeHandle = setInterval(function () {
        timeNum.innerHTML = parseInt((new Date() - beginTime) / 1000);
    }, 1000);
}

function bind(row, col) {
    var elem = document.getElementById("m_" + row + "_" + col);
    elem.onmousedown = function (e) {
        e = e || window.event;
        var mouseNum = e.button;
        if (mouseNum == 2) {
            if (elem.className == "flag") {
                elem.className = "";
                markedCount++;
            } else {
                elem.className = "flag";
                markedCount--;
            }
            mineNum.innerHTML = markedCount;
        } else if (elem.className != "flag") {
            openBlock(elem, row, col);
        }
    };
}

function openBlock(elem, row, col) {
    var elem = document.getElementById("m_" + row + "_" + col);
    if(mineArr[row][col] == 9){//如果点到了是雷的
        elem.className = "landMine";
        lose();
    }
    else{//如果点到的不是雷
        elem.className = "normal";
        elem.onmousedown = null;    //关闭点击响应
        blockCount++;   //已经展开的格子数+1
        if(blockCount==85){//如果已经将不是雷的全部点开
            win();
        }
        //显示数字，若为0，则继续递归显示周边区域
        if(mineArr[row][col] != 0){
            elem.innerHTML = mineArr[row][col];
        }
        else{
            showBlank(row,col);
        }
    }
}

function showBlank(row,col){
    for (var i = row - 1; i < row + 2; i++)
        for (var j = col - 1; j < col + 2; j++) {
            if (!(i == row && j == col)) {
                var elem = document.getElementById("m_" + i + "_" + j);
                if (elem != null && elem.className == "") {
                    openBlock(elem, i, j);
                }
            }
        }
}

function win() {
    alert("Congratulation! Only cost " + timeNum.innerHTML +" s");
    location.reload();
}

function lose() {
    alert("Unfortunately you lose. Try again!");
    location.reload();
}
