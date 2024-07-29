/*
 * AUTHOR: toydotgame
 * CREATED ON: 2023-12-16
 * Content-loading script so that I can update nav, header and footer,
 * etc all here and have it dynamically update across all pages.
 */

document.getElementById("nav").innerHTML = `
<div id="navpfp"></div><h1>toydotgame</h1>
<a href="/home">home</a>
|
<a href="/blog/">blog</a>
|
<a href="/projects">projects</a>
|
<a href="/utils">utils</a>
|
<a href="/">card</a>
|
<a href="/jp/">日本語</a>
<hr>
`;

import {} from "/imgmodal.js";

var recentblogs = `
<div id="recentblogs">
<h1>Recent Blog Posts</h1>
<ul>
	<li><a href="/blog/2024-07-23_mbs"><b>2024-07-23:</b> The Tale of Minecraft's Baddest Server</a></li>
	<li><a href="/blog/2024-06-17_versioning"><b>2024-06-17:</b> toy's Standardised Versioning</a></li>
	<li><a href="/blog/2024-01-03_fs-measurements"><b>2024-01-03:</b> Digital Metric Unit Nomenclature for Dummies</a></li>
	<li><a href="/blog/2024-01-01_web-design"><b>2024-01-01:</b> What's the deal with Modern Web Design?</a></li>
	<li><a href="/blog/2024-01-01_spigot-dating-sucks"><b>2024-01-01:</b> Minecraft Server Crashing? Try This. – or (Another Reason) why Spigot Sucks</a></li>
</ul>
</div>
`;

var badges = `
<img src="/media/badges/toydotgame.gif" width="88">
<img src="/media/badges/lucida.gif" width="88">
<a href="https://www.7-zip.org/"><img src="/media/badges/7z.gif" width="88"></a>
<img src="/media/badges/win7.gif" width="88">
<img src="/media/badges/invalidator.gif" width="88">
<img src="/media/badges/vcss-blue.gif" width="88">
<a href="http://www.wtfpl.net/"><img src="/media/badges/wtfpl.gif" width="88"></a>
<a href="https://thardwardy.github.io/"><img src="/media/badges/thardwardy.gif" width="88"></a>
<img src="/media/badges/2019.gif" width="88">
<a href="https://cyber.dabamos.de/88x31/"><img src="/media/badges/88x31.gif" width="88"></a>
<img src="/media/badges/abrowser.gif" width="88">
<img src="/media/badges/anythingbut.gif" width="88">
<a href="https://archlinux.org/"><img src="/media/badges/archlinux.gif" width="88"></a>
<img src="/media/badges/cssdif.gif" width="88">
<a href="https://www.dell.com/"><img src="/media/badges/dell.gif" width="88"></a>
<a href="https://www.mozilla.org/en-US/firefox/new/"><img src="/media/badges/firefox3.gif" width="88"></a>
<img src="/media/badges/gregg.gif" width="88">
<a href="https://archive.org/donate"><img src="/media/badges/internetarchive.gif" width="88"></a>
<img src="/media/badges/miku.gif" width="88">
<a href="https://minecraft.net/"><img src="/media/badges/minecraft.gif" width="88"></a>
<img src="/media/badges/minibanner.gif" width="88">
<img src="/media/badges/right2repair.gif" width="88">
<a href="https://yesterweb.org/no-to-web3/"><img src="/media/badges/roly-saynotoweb3.gif" width="88"></a>
<img src="/media/badges/transnow2.gif" width="88">
<a href="https://donate.wikimedia.org/><img src="/media/badges/wikipedia.gif" width="88"></a>
`;
export { badges };

var footer = `
<br>
<a href="https://www.free-website-hit-counter.com/"><img src="https://www.free-website-hit-counter.com/c.php?d=6&id=160327&s=5" width="88"></a>
<p>Website <copyleft></copyleft> 2024 toydotgame</p>
`;

/*
 * Footer replacement shouldn't run on Japanese-language pages. `/jp/contento.js` handles that.
 * However, this script is called and run by `contento.js`'s import statement.
 */
if(!window.location.pathname.startsWith("/jp/")) {
	try {
		document.getElementById("footer").innerHTML = "<hr>" + recentblogs + badges + footer;
	} catch {
		document.getElementById("blogfooter").innerHTML = "<hr>" + badges + footer;
		document.getElementById("blogfooter").id = "footer";
	}
}
