/* RESET CSS --------------------------------- */
{$mainClassName} * {
	margin: 0;
	padding: 0;
	border: 0;
	font: inherit;
	font-size: 100%;
	vertical-align: baseline;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

/* HTML5 display-role reset for older browsers */
{$mainClassName} section {
	display: block;
}

{$mainClassName} {
	line-height: 1;
}

{$mainClassName} ul {
	list-style: none;
}

{$mainClassName} strong {
	font-weight: 700;
}

{$mainClassName} img {
	max-width: 100%;
	display: block;
	height: auto;
}

{if isset($loadFonts) && $loadFonts eq 'true'}
@font-face {
	font-family: 'Unit Offc Pro';
	src: url('{Zend_Registry::get("application")->getBaseUrl()}references/font/eot'); /* IE9 Compat Modes */
	src: url('{Zend_Registry::get("application")->getBaseUrl()}references/font/eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
	url('{Zend_Registry::get("application")->getBaseUrl()}references/font/woff') format('woff'), /* Pretty Modern Browsers */
	url('{Zend_Registry::get("application")->getBaseUrl()}references/font/ttf')  format('truetype'), /* Safari, Android, iOS */
	url('{Zend_Registry::get("application")->getBaseUrl()}references/font/svg#unitoffcpro') format('svg'); /* Legacy iOS */
	font-weight: normal;
	font-style: normal;
}
{/if}

/* MAIN Css */
{$mainClassName} {
	max-width:1340px;
	margin: 0 auto;
	font-size: 1em;
	letter-spacing: 0px;
	font-family: {if isset($loadFonts) && $loadFonts eq 'true'}"Unit Offc Pro",{/if} Arial, Tahoma, sans-serif;
}

{$mainClassName} .{$cssClassPrefix}content * {
position:relative;
}

{$mainClassName} .{$cssClassPrefix}content .{$cssClassPrefix}referenceList  {

}

{$mainClassName} .{$cssClassPrefix}referenceList  li.{$cssClassPrefix}listItem  {
	overflow: hidden;
	margin-top:1px;
}

{$mainClassName} .{$cssClassPrefix}fullInfoLink {
position: absolute;
left: 0;
top: 0;
z-index: 3;
width: 100%;
height: 100%;
}


{$mainClassName} .{$cssClassPrefix}info {
	position: absolute;
	left: 0;
	top: 1.8em;
	z-index: 2;
	width: 100%;
}

@media only screen and (max-width: 479px)
{
	{$mainClassName} .{$cssClassPrefix}info {
		top: 0.5em;
	}
}

{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}section {
	padding: 0 2.5%;
	margin: 0 1%;
}

{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}line {
	display: block;
	width: 0;
	height: 4px;
	margin-bottom: 20px;
	-webkit-transition: all 0.6s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.6s cubic-bezier(0.645, 0.045, 0.355, 1);
}

{$mainClassName} .{$cssClassPrefix}itemConteiner:hover  .{$cssClassPrefix}line {
	width: 100px;
}

{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}title{
	font-size: 30px;
	line-height: 34px;
	font-weight: 300;
	margin-bottom: 20px;
}

@media only screen and (max-width: 479px)
{
	{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}title {
		font-size: 20px;
		line-height: 24px;
	}
}

{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}desc{
	width: 75%;
	opacity: 0.7;
	font-size:0.8em;
	margin-bottom: 20px;
}

@media only screen and (max-width: 479px)
{
	{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}desc {
		display:none;
	}
}

{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}text{
	opacity: 0;
	-webkit-transform: translateY(-15%);
	transform: translateY(-15%);
	-webkit-transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
}

{$mainClassName} .{$cssClassPrefix}itemConteiner:hover  .{$cssClassPrefix}info .{$cssClassPrefix}text {
	opacity: 1;
	-webkit-transform: translateY(0);
	transform: translateY(0);
}

@media only screen and (max-width: 960px)
{
	{$mainClassName} .{$cssClassPrefix}info .{$cssClassPrefix}text {
		display:none;
	}
}


{$mainClassName} .{$cssClassPrefix}details {
	position: absolute;
	right: 0;
	bottom: 5px;
	z-index: 4;
	width: 100%;
}

@media only screen and (max-width: 960px)
{
	{$mainClassName} .{$cssClassPrefix}details {
		display:none;
	}
}


{$mainClassName} .{$cssClassPrefix}details .{$cssClassPrefix}section {
	padding: 0 2%;
	margin: 0 1%;
}

{$mainClassName} .{$cssClassPrefix}details .{$cssClassPrefix}column {
	width: 23%;
	margin: 0 1% 2.5%;
	float: right;
	opacity: 0;
	-webkit-transform: translateY(-7%);
	transform: translateY(-7%);
	padding: 20px 10px;
	-webkit-transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
}

{$mainClassName} .{$cssClassPrefix}details .{$cssClassPrefix}section .{$cssClassPrefix}column:first-child {
	-webkit-transition-delay: 0.2s;
	transition-delay: 0.2s;
}

{$mainClassName} .{$cssClassPrefix}details .{$cssClassPrefix}section .{$cssClassPrefix}column:nth-child(2) {
	-webkit-transition-delay: 0.3s;
	transition-delay: 0.3s;
}

{$mainClassName} .{$cssClassPrefix}details .{$cssClassPrefix}section .{$cssClassPrefix}column:nth-child(3) {
	-webkit-transition-delay: 0.4s;
	transition-delay: 0.4s;
}

{$mainClassName} .{$cssClassPrefix}itemConteiner:hover  .{$cssClassPrefix}details .{$cssClassPrefix}column {
	opacity: 1;
	-webkit-transform: translateY(0);
	transform: translateY(0);
}

{$mainClassName} .{$cssClassPrefix}column .title {
	font-weight: 300;
	margin-bottom: 1em;
	font-size: 0.9em;
	line-height: 1.2em;
	opacity: 0.8;
}

{$mainClassName} .{$cssClassPrefix}column p {
	font-weight: 300;
	margin-bottom: 1em;
	font-size: 0.9em;
	line-height: 1.2em;
	opacity: 0.9;
}

{$mainClassName} .{$cssClassPrefix}imgContainer {
	line-height: 0;
	position: relative;
}


{$mainClassName} .{$cssClassPrefix}mask {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	z-index: 1;
	opacity: 0;
	-webkit-transition: all 0.6s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.6s cubic-bezier(0.645, 0.045, 0.355, 1);
}

{$mainClassName} .{$cssClassPrefix}itemContainer:hover .{$cssClassPrefix}mask {
	opacity: 1;
}

/* Container TOP, BOTTOM */
{$mainClassName} .{$cssClassPrefix}containerTop {
	overflow:hidden;
	min-height:37px;
}

{$mainClassName} .{$cssClassPrefix}containerBottom {
	overflow:hidden;
	min-height:37px;
}

/* FILTERS */
{$mainClassName} .{$cssClassPrefix}filters {
	width:30%;
	float:right;
	text-align: right;
	position: relative;
}

{$mainClassName} .{$cssClassPrefix}filters .{$cssClassPrefix}companyType {
	position: relative;
	-webkit-transform: translateY(10%);
	transform: translateY(10%);
}

/* PAGINATION Css */
{$mainClassName} .{$cssClassPrefix}pagination {
	width:70%;
	float:left;
}

{$mainClassName} .{$cssClassPrefix}paginationBottom {
	padding-top:0;
}

{$mainClassName}  .{$cssClassPrefix}paginationList{
	text-align:left;
}


{$mainClassName} .{$cssClassPrefix}paginationList .{$cssClassPrefix}listItem{
	display:inline-block;
}

{$mainClassName} .{$cssClassPrefix}paginationList a {
	text-decoration:none;
	padding: 0.6em 1em;
	font-size: 1em;
	margin: 0 1px;
	display:block;
	-webkit-transition: all 0.6s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.6s cubic-bezier(0.645, 0.045, 0.355, 1);
}


.{$cssClassPrefix}preloader  {
	position: relative;
	height:55px;
}

.{$cssClassPrefix}preloader .loader {
	position: absolute;
	left: 50%;
	top: 50%;
	width:55px;
	height:55px;
	margin-left: -27.5px;
	margin-top: -27.5px;
}

.{$cssClassPrefix}preloader .square {
	background: #f2f2f2;
	width: 15px;
	height: 15px;
	float: left;
	top: -10px;
	margin-right: 5px;
	margin-top: 5px;
	position: relative;
	opacity: 0;
	-webkit-animation: enter 6s infinite;
	animation: enter 6s infinite;
}

.{$cssClassPrefix}preloader .enter {
	top: 0px;
	opacity: 1;
}

.{$cssClassPrefix}preloader .square:nth-child(1) {
	-webkit-animation-delay: 1.8s;
	-moz-animation-delay: 1.8s;
	animation-delay: 1.8s;
}

.{$cssClassPrefix}preloader .square:nth-child(2) {
	-webkit-animation-delay: 2.1s;
	-moz-animation-delay: 2.1s;
	animation-delay: 2.1s;
}

.{$cssClassPrefix}preloader .square:nth-child(3) {
	-webkit-animation-delay: 2.4s;
	-moz-animation-delay: 2.4s;
	animation-delay: 2.4s;
	background: #a79878;
}

.{$cssClassPrefix}preloader .square:nth-child(4) {
	-webkit-animation-delay: 0.9s;
	-moz-animation-delay: 0.9s;
	animation-delay: 0.9s;
}

.{$cssClassPrefix}preloader .square:nth-child(5) {
	-webkit-animation-delay: 1.2s;
	-moz-animation-delay: 1.2s;
	animation-delay: 1.2s;
}

.{$cssClassPrefix}preloader .square:nth-child(6) {
	-webkit-animation-delay: 1.5s;
	-moz-animation-delay: 1.5s;
	animation-delay: 1.5s;
}

.{$cssClassPrefix}preloader .square:nth-child(8) {
	-webkit-animation-delay: 0.3s;
	-moz-animation-delay: 0.3s;
	animation-delay: 0.3s;
}

.{$cssClassPrefix}preloader .square:nth-child(9) {
	-webkit-animation-delay: 0.6s;
	-moz-animation-delay: 0.6s;
	animation-delay: 0.6s;
}

.{$cssClassPrefix}preloader .clear {
	clear: both;
}

.{$cssClassPrefix}preloader .last {
	margin-right: 0;
}

@-webkit-keyframes enter {
	0% {
		opacity: 0;
		top: -10px;
	}
	5% {
		opacity: 1;
		top: 0px;
	}
	50.9% {
		opacity: 1;
		top: 0px;
	}
	55.9% {
		opacity: 0;
		top: 10px;
	}
}

@keyframes enter {
	0% {
		opacity: 0;
		top: -10px;
	}
	5% {
		opacity: 1;
		top: 0px;
	}
	50.9% {
		opacity: 1;
		top: 0px;
	}
	55.9% {
		opacity: 0;
		top: 10px;
	}
}
@-moz-keyframes enter {
	0% {
		opacity: 0;
		top: -10px;
	}
	5% {
		opacity: 1;
		top: 0px;
	}
	50.9% {
		opacity: 1;
		top: 0px;
	}
	55.9% {
		opacity: 0;
		top: 10px;
	}
}
