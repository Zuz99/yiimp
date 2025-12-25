<!doctype html>
<!--[if IE 7 ]>		 <html class="no-js ie ie7 lte7 lte8 lte9" lang="en-US"> <![endif]-->
<!--[if IE 8 ]>		 <html class="no-js ie ie8 lte8 lte9" lang="en-US"> <![endif]-->
<!--[if IE 9 ]>		 <html class="no-js ie ie9 lte9>" lang="en-US"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html class="no-js" lang="en-US"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<meta name="description" content="yiimp mining pool for bitcoin and altcoin with auto profit switch and auto exchange">
	<meta name="keywords" content="yiimp,anonymous,mining,pool,maxcoin,bitcoin,altcoin,auto,switch,exchange,profit">

<?php
	
$pageTitle = empty($this->pageTitle) ? YAAMP_SITE_NAME : YAAMP_SITE_NAME." - ".$this->pageTitle;
echo '<title>'.$pageTitle.'</title>';

echo CHtml::cssFile("/extensions/jquery/themes/ui-lightness/jquery-ui.css");
echo CHtml::cssFile('/yaamp/ui/css/main.css');
echo CHtml::cssFile('/yaamp/ui/css/table.css');
// Cache-bust for CSS/JS so browsers pick up changes after deploy
$v_modern = @filemtime(dirname(__DIR__).'/css/modern.css');
if(!$v_modern) $v_modern = time();
echo CHtml::cssFile('/yaamp/ui/css/modern.css?v='.$v_modern);
//echo CHtml::scriptFile('/yaamp/ui/js/jquery.tablesorter.js');

//echo CHtml::scriptFile('/extensions/jquery/js/jquery-1.8.3-dev.js');
//echo CHtml::scriptFile('/extensions/jquery/js/jquery-ui-1.9.1.custom.min.js');

$cs = app()->getClientScript();
$cs->registerCoreScript('jquery.ui');

// UI theme switcher (no functional impact)
$v_themejs = @filemtime(dirname(__DIR__).'/js/theme.js');
if(!$v_themejs) $v_themejs = time();
echo CHtml::scriptFile('/yaamp/ui/js/theme.js?v='.$v_themejs);

echo "</head>";
