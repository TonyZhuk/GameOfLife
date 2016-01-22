/**
 * Created by anton on 22.11.15.
 */

var number_of_rows = 30;
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
for(var i = 0; i < number_of_rows*number_of_rows - 1; i++){
    if (a[i] == 1) cells[i].style.backgroundColor = '#FFB739';
}


 if(document.getElementById('name') != null) {
 document.getElementById('name').appendChild(t);
 }