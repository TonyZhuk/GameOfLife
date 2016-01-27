/**
 * Created by anton on 22.11.15.
 */

var number_of_rows = 40;
var a = gon.array;
var t = document.createElement('table');
var tbody = document.createElement('tbody');
for(var i = 0;i<number_of_rows;i++) {
    var tr = document.createElement('tr');
    for (var j = 0;j<number_of_rows;j++){
        var td = document.createElement('td');
        td.style.backgroundColor = '#336699';
        tr.appendChild(td);
    }
    tbody.appendChild(tr);
}
t.appendChild(tbody);

cells = t.getElementsByTagName('td');
for(var i = 0; i < number_of_rows*number_of_rows - 1; i++) {
    if (a[i] == 1) cells[i].style.backgroundColor = '#FFB739';
}

 if(document.getElementById('name') != null) {
     document.getElementById('name').appendChild(t);
 }

$("td").click(function() {
    var col = +$(this).parent().children().index($(this));
    var row = +$(this).parent().parent().children().index($(this).parent());
    var c = row * number_of_rows + col;
    if (a[c] == 0) {
        $(this).css("background-color", "#FFB739");
        a[c] = 1;
    } else if (a[c] == 1){
        $(this).css("background-color", "#336699");
        a[c] = 0;
    }
});


