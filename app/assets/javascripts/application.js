// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require_tree .
function search(){
  // Declare variables
  var input, search_filter, table, tr, td_array, i;
  input = document.querySelector("#search_function");
  search_filter = input.value.toUpperCase();
  table = document.querySelector("table");
  tr = table.querySelectorAll("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 3; i < tr.length; i++) {
    td_array = tr[i].querySelectorAll("td")
    if (check_filter(td_array, search_filter)) {
      tr[i].style.display = "";
    } else {
      tr[i].style.display = "none";
    }
  }
};

function check_filter(node_array, search_filter){
  if (!node_array){
    return false;
  }
  let str = '';
  node_array.forEach(function(x){
    return str += x.innerHTML.toUpperCase()
  });
  return str.indexOf(search_filter) > -1
}
