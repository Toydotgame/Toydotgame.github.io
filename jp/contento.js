/*
 * AUTHOR: toydotgame
 * CREATED ON: 2023-12-16
 * Content-loading script for JP pages.
 */

import { badges } from "/contentloader.js";

document.getElementById("nav").innerHTML = `
<div id="navpfp"></div><h1>トイドットゲーム</h1>
<a href="/jp/">トップ</a>
|
<a href="/jp/burogu/">ブログ</a>
|
<a href="/">カード（英語）</a>
|
<a href="/home">English</a>
<hr>
`;

var recentblogs = `
<div id="recentblogs">
<h1>最新</h1>
<ul>
	<li><a href="/jp/burogu/2024-02-27_jidouhanbaiki"><b>２０２３年０２月２７日:</b> 自動販売機</a></li>
	<li><a href="/jp/burogu/2023-04-04_saito4"><b>２０２３年０４月０４日:</b> このサイトが４回書き換えっています！</a></li>
</ul>
</div>
`;

var footer = `
<br>
<a href="https://www.free-website-hit-counter.com/"><img src="https://www.free-website-hit-counter.com/c.php?d=6&id=160327&s=5" width="88"></a>
<p>このサイトは <copyleft></copyleft> ２０２４年 トイドットゲーム</p>
`;

try {
	document.getElementById("footer").innerHTML = "<hr>" + recentblogs + badges + footer;
} catch {
	document.getElementById("blogfooter").innerHTML = "<hr>" + badges + footer;
	document.getElementById("blogfooter").id = "footer";
}
