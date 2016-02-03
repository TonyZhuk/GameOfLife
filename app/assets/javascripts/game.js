var number_of_rows = 20;
array = gon.array;
generation_counter = 0;
    t = document.createElement('table');
    var tbody = document.createElement('tbody');
    for(var i = 0;i<number_of_rows;i++) {
        var tr = document.createElement('tr');
        for (var j = 0;j<number_of_rows;j++){
            var td = document.createElement('td');
            tr.appendChild(td);
        }
        tbody.appendChild(tr);
    }
    t.appendChild(tbody);

    cells = t.getElementsByTagName('td');
    for(var i = 0; i < number_of_rows*number_of_rows; i++) {
        if (array[i] == 1) cells[i].style.backgroundColor = '#FFB739';
    }

    if(document.getElementById('name') != null) {
        document.getElementById('name').appendChild(t);
    }

    var next_step_button = document.createElement("BUTTON");
    next_step_button.id = "next_step_button";
    next_step_button.innerHTML = "NEXT STEP";
    document.getElementById('name').appendChild(next_step_button);

    var reset_button = document.createElement("BUTTON");
    reset_button.id = "reset_button";
    reset_button.innerHTML = "Reset Game";
    document.getElementById('name').appendChild(reset_button);

$('#next_step_button').click(function() {
    $.ajax({
        url: "/games",
        type: "POST",
        cache: false,
        data: {'array[]': array,'game': "run"},
        success: function(next_gen){
            show(next_gen)
            update_counter()
        }
    });
});

$('#reset_button').click(function() {
    $.ajax({
        url: "/games",
        type: "GET",
        cache: false,
        data: {'game': "reset"},
        success: function(next_gen){
            show(next_gen)
            reset_counter()
        }
    });
});

function update_counter(){
    generation_counter += 1;
    $("#counter").text(generation_counter);
}

function reset_counter(){
    generation_counter = 0;
    $("#counter").text(generation_counter);
}

function show(next_gen){
    cells = t.getElementsByTagName('td');
    for(var i = 0; i < number_of_rows*number_of_rows - 1; i++) {
        cells[i].style.backgroundColor = '#336699';
    }
    for(var i = 0; i < number_of_rows*number_of_rows - 1; i++) {
        if (next_gen[i] == 1) cells[i].style.backgroundColor = '#FFB739';
    }
    array = next_gen;
}

$( document ).ready(function() {
    $("#counter").text(generation_counter);
    $("td").click(function() {
        var col = +$(this).parent().children().index($(this));
        var row = +$(this).parent().parent().children().index($(this).parent());
        var c = row * number_of_rows + col;
        if (array[c] == 0) {
            $(this).css("background-color", "#FFB739");
            array[c] = 1;
        } else if (array[c] == 1){
            $(this).css("background-color", "#336699");
            array[c] = 0;
        }
    });
});







