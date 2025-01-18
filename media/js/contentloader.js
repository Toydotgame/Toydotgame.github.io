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
<a href="/projects/">projects</a>
|
<a href="/utils">utils</a>
|
<a href="/">card</a>
<hr>
`;

import {} from "/media/js/imgmodal.js";

var recentblogs = `
<div id="recentblogs">
<h1>Recent Blog Posts</h1>
<ul>
	<li><a href="/blog/2025/01-18_how-to-downgrade-from-ios-9-to-6.html"><b>2025-01-18:</b> How to Downgrade from iOS 9 to iOS 6</a></li>
	<li><a href="/blog/2024/07-23_mbs"><b>2024-07-23:</b> The Tale of Minecraft's Baddest Server</a></li>
	<li><a href="/blog/2024/06-17_versioning"><b>2024-06-17:</b> toy's Standardised Versioning</a></li>
	<li><a href="/blog/2024/01-03_fs-measurements"><b>2024-01-03:</b> Digital Metric Unit Nomenclature for Dummies</a></li>
	<li><a href="/blog/2024/01-01_web-design"><b>2024-01-01:</b> What's the deal with Modern Web Design?</a></li>
</ul>
</div>
`;

var badges = `
<img src="/media/resources/badges/toydotgame.gif" width="88">
<a href="https://one.one.one.one/"><img src="/media/resources/badges/1.1.1.1.gif" width="88"></a>
<img src="/media/resources/badges/8pride.gif" width="88">
<a href="https://web.archive.org/web/19980509035420if_/http://www.apple.com/"><img src="/media/resources/badges/apple.gif" width="88"></a>
<img src="/media/resources/badges/bi.gif" width="88">
<a href="https://escargot.chat/"><img src="/media/resources/badges/escargot.gif" width="88"></a>
<img src="/media/resources/badges/genderfluid.gif" width="88">
<img src="/media/resources/badges/mslive.gif" width="88">
<img src="/media/resources/badges/nyaabanner.gif" width="88">
<img src="/media/resources/badges/trans.gif" width="88">
<img src="/media/resources/badges/virtualdiva.gif" width="88">
<a href="https://en.wikipedia.org/"><img src="/media/resources/badges/wikipedia.gif" width="88"></a>
<img src="/media/resources/badges/lucida.gif" width="88">
<a href="https://www.7-zip.org/"><img src="/media/resources/badges/7z.gif" width="88"></a>
<img src="/media/resources/badges/win7.gif" width="88">
<img src="/media/resources/badges/invalidator.gif" width="88">
<img src="/media/resources/badges/vcss-blue.gif" width="88">
<a href="https://thardwardy.com/"><img src="/media/resources/badges/thardwardy.gif" width="88"></a>
<img src="/media/resources/badges/2019.gif" width="88">
<a href="https://cyber.dabamos.de/88x31/"><img src="/media/resources/badges/88x31.gif" width="88"></a>
<img src="/media/resources/badges/abrowser.gif" width="88">
<img src="/media/resources/badges/anythingbut.gif" width="88">
<a href="https://archlinux.org/"><img src="/media/resources/badges/archlinux.gif" width="88"></a>
<img src="/media/resources/badges/cssdif.gif" width="88">
<a href="https://www.dell.com/"><img src="/media/resources/badges/dell.gif" width="88"></a>
<a href="https://www.mozilla.org/en-US/firefox/new/"><img src="/media/resources/badges/firefox3.gif" width="88"></a>
<img src="/media/resources/badges/gregg.gif" width="88">
<a href="https://archive.org/donate"><img src="/media/resources/badges/internetarchive.gif" width="88"></a>
<img src="/media/resources/badges/miku.gif" width="88">
<a href="https://minecraft.net/"><img src="/media/resources/badges/minecraft.gif" width="88"></a>
<img src="/media/resources/badges/minibanner.gif" width="88">
<img src="/media/resources/badges/right2repair.gif" width="88">
<a href="https://yesterweb.org/no-to-web3/"><img src="/media/resources/badges/roly-saynotoweb3.gif" width="88"></a>
<img src="/media/resources/badges/transnow2.gif" width="88">
<a href="https://donate.wikimedia.org/"><img src="/media/resources/badges/donate-wikipedia.gif" width="88"></a>
`;
export { badges };

var footer = `
<br>
<a href="https://www.free-website-hit-counter.com/"><img src="https://www.free-website-hit-counter.com/c.php?d=6&id=160327&s=5" width="88"></a>
<p>Website <copyleft></copyleft> 2025 toydotgame</p>
`;

try {
	document.getElementById("footer").innerHTML = "<hr>" + recentblogs + badges + footer;
} catch {
	document.getElementById("blogfooter").innerHTML = "<hr>" + badges + footer;
	document.getElementById("blogfooter").id = "footer";
}
