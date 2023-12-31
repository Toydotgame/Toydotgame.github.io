/*
 * AUTHOR: toydotgame
 * CREATED ON: 2024-01-01
 * Code to add an image popup modal on click. 
 */

document.getElementById("content").innerHTML += '<div id="modaldim" style="display:none;"></div>';
var overlay = document.getElementById("modaldim");
overlay.addEventListener("click", onClick);

for(var i = 0; i <= document.getElementById("content").getElementsByTagName("img").length - 1; i++) {
	console.log("Adding event listener to: " + document.getElementsByTagName("img")[i].outerHTML);
	document.getElementsByTagName("img")[i].addEventListener("click", onClick);
}

overlay.innerHTML = '<img id="modalimg">';
var img = document.getElementById("modalimg");

function onClick(e) {
	img.src = e.target.src;
	if(overlay.style.display == "none") {
		overlay.style.display = "block";
		return;
	}
	overlay.style.display = "none";
}
