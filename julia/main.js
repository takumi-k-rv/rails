class Todo {
    constructor(textField1, textField2, textField3, textField4, textField5, sendButton) {
        this.textField1 = textField1;
        this.textField2 = textField2;
        this.textField3 = textField3;
        this.textField4 = textField4;
        this.textField5 = textField5;

        this.sendButton = sendButton;
        this.host     = "http://localhost:3001/satori/julia";
        this.setEventListener();
    }

    setEventListener() { //send click
        var _this = this
        this.sendButton.addEventListener("click", function(e) {
            var minX = _this.textField1.value;
            var maxX = _this.textField2.value;
            var minY = _this.textField3.value;
            var maxY = _this.textField4.value;
            var compConst = _this.textField5.value;
            //console.log(s);

            _this.postJulia(minX,maxX,minY,maxY,compConst);
        });
    }

    postJulia(minX, maxX, minY, maxY, compConst) { // post /julia_params
        var _this = this
        axios.post(this.host, { min_x: minX, max_x: maxX, min_y: minY, max_y: maxY, comp_const: compConst })
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
                m += hash.data[key];
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
