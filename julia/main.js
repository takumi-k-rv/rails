class Todo {
    constructor(textField1, textField2, textField3, textField4, textField5, sendButton) {
        this.textField1 = textField1;
        this.textField2 = textField2;
        this.textField3 = textField3;
        this.textField4 = textField4;
        this.textField5 = textField5;

        this.sendButton = sendButton;
        this.host     = "http://localhost:3001";
        this.setEventListener();
    }

    setEventListener() { //send click
        var _this = this
        this.sendButton.addEventListener("click", function(e) {
            var minX = _this.textField1.value;
            var maxX = _this.textField2.value;
            var minY = _this.textField3.value;
            var maxY = _this.textField4.value;
            var constReal=0;
            var constImg=0;

            var s = _this.textField5.value;
            //console.log(s);


            if(s.match(/^i$/)) {
                constReal=0;
                constImg=1;
            } else if(s.match(/^-i$/)) {
                constReal=0;
                constImg=-1;
            } else if(s.match(/^(-?\d+(.\d+)?)\+i$/)) {
                constReal=s.replace(/^(-?\d+(.\d+)?)\+i$/,"$1");
                constImg=1;
            } else if(s.match(/^(-?\d+(.\d+)?)\-i$/)) {
                constReal=s.replace(/^(-?\d+(.\d+)?)-i$/,"$1");
                constImg=-1;
            } else if(s.match(/^(-?\d+(.\d+)?)$/)) {
                constReal=s.replace(/^(-?\d+(.\d+)?)$/,"$1");
                constImg=0;
            } else if(s.match(/^(-?\d+(.\d+)?)i$/)) {
                constReal=0;
                constImg=s.replace(/^(-?\d+(.\d+)?)i$/,"$1");
            } else if(s.match(/^(-?\d+(.\d+)?)\+(\d+(.\d+)?)i$/)) {
                constReal=s.replace(/^(-?\d+(.\d+)?)\+(\d+(.\d+)?)i$/,"$1");
                constImg=s.replace(/^(-?\d+(.\d+)?)\+(\d+(.\d+)?)i$/,"$3");
            } else if(s.match(/^(-?\d+(.\d+)?)(-\d+(.\d+)?)i$/)) {
                constReal=s.replace(/^(-?\d+(.\d+)?)(-\d+(.\d+)?)i$/,"$1");
                constImg=s.replace(/^(-?\d+(.\d+)?)(-\d+(.\d+)?)i$/,"$3");
            } else {
                constReal="";
                constImg="";
            }

            _this.postJulia(minX,maxX,minY,maxY, constReal, constImg);
        });
    }

    postJulia(minX, maxX, minY, maxY, constReal, constImg) { // post /julia_params
        var _this = this
        axios.post(this.host + '/julia_params', { min_x: minX, max_x: maxX, min_y: minY, max_y: maxY, real: constReal, img: constImg })
            .then(function(res) {
                var julia = res.data;
                _this.appendJulia(julia);
                _this.removeTextFromInput();
            });
    }

    removeTextFromInput() {
        this.textField1.value = '';
        this.textField2.value = '';
        this.textField3.value = '';
        this.textField4.value = '';
        this.textField5.value = '';
    }

    appendJulia(julia) { // 画像処理
        var hash = julia;
        console.log(hash)
        if(hash.status === "ERROR") {
            console.log(hash.data)
            var m='';

            Object.keys(hash.data).map( function(key) {
                if(key === 'min_x') {
                    m += "Invalid input of min_x.\n";
                } else if(key === 'max_x') {
                    m += "Invalid input of max_x.\n";
                } else if(key === 'min_y') {
                    m += "Invalid input of min_y.\n";
                } else if(key === 'max_y') {
                    m += "Invalid input of max_y.\n";
                } else if(key === 'img') {
                    m += "Invalid input of comp_const.\n";
                }
            });

            alert(m);
        }
        else if(hash.status === "SUCCESS") {
            var canvas1 = document.getElementById('canvas1');
            if ( ! canvas1 || ! canvas1.getContext ) { return false; }
            var c1 = canvas1.getContext('2d');

            var i,j;
            var hash = julia.data;
            var coo = /^(\d+)_(\d+)$/;

            Object.keys(hash).map( function(key) {
                c1.beginPath();
                i=key.replace(coo,"$1");
                j=key.replace(coo,"$2");

                var r=255/100*hash[key];

                var red = (r).toString();

                c1.fillStyle = 'rgb('+red+',0,0)';

                c1.rect(i,j, 1, 1);
                c1.fill(); // 色を塗る
            });
        }
    }
}


window.onload = function() { //初期状態
    console.log('hello');

    todo = new Todo(
        document.getElementById("field1"),
        document.getElementById("field2"),
        document.getElementById("field3"),
        document.getElementById("field4"),
        document.getElementById("field5"),
        document.getElementById("btn"),
    )
}
