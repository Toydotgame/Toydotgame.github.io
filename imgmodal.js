/*
 * AUTHOR: toydotgame
 * CREATED ON: 2024-01-01
 * Code to add an image popup modal on click. 
 */

document.getElementById("content").innerHTML += '<div id="modaldim" style="display:none;"></div>';
var overlay = document.getElementById("modaldim");
overlay.addEventListener("click", onClick);

var imgs = document.getElementById("content").getElementsByTagName("img");
for(var i = 0; i <= imgs.length - 1; i++) {
	imgs[i].addEventListener("click", onClick);
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
