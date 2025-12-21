<?php

/**
 * Yiimp main layout.
 *
 * This project historically used a custom fixed "tabmenu" header + legacy CSS.
 * To make the UI feel more modern (Ubuntu 22/24 era browsers) without rewriting
 * all Yii 1.1 views, we keep the existing content rendering but wrap it in a
 * Bootstrap 5 navbar + container and add a small modern stylesheet.
 */

require('misc.php');

echo <<<END

<!doctype html>
<!--[if IE 7 ]>         <html class="no-js ie ie7 lte7 lte8 lte9" lang="en-US"> <![endif]-->
<!--[if IE 8 ]>         <html class="no-js ie ie8 lte8 lte9" lang="en-US"> <![endif]-->
<!--[if IE 9 ]>         <html class="no-js ie ie9 lte9>" lang="en-US"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html class="no-js" lang="en-US"> <!--<![endif]-->

<head>

<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1" />

<meta name="description" content="Yii mining pools for alternative crypto currencies">
<meta name="keywords" content="anonymous,mining,pool,maxcoin,bitcoin,altcoin,auto,switch,exchange,profit,decred,scrypt,x11,x13,x14,x15,lbry,lyra2re,neoscrypt,sha256,quark,skein2">

END;

$pageTitle = empty($this->pageTitle) ? YAAMP_SITE_NAME : YAAMP_SITE_NAME." - ".$this->pageTitle;
echo '<title>'.$pageTitle.'</title>';

// Core legacy styles (tables, legacy widgets)
echo CHtml::cssFile("/extensions/jquery/themes/ui-lightness/jquery-ui.css");
echo CHtml::cssFile('/yaamp/ui/css/main.css');
echo CHtml::cssFile('/yaamp/ui/css/table.css');

// Bootstrap 5 + Icons (CDN). Keep it simple and compatible.
echo '<link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin>';
echo '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">';
echo '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" crossorigin="anonymous">';

// Modern theme overrides for Yiimp
echo CHtml::cssFile('/yaamp/ui/css/modern.css');

// Theme init (applies data-bs-theme early to avoid flash)
echo CHtml::scriptFile('/yaamp/ui/js/theme.js');

$cs = app()->getClientScript();
$cs->registerCoreScript('jquery.ui');
echo CHtml::scriptFile('/yaamp/ui/js/jquery.tablesorter.js');

echo "</head>";

echo '<body class="page yiimp-modern">';
echo '<a href="/site/mainbtc" style="display: none;">main</a>';

showPageHeader();
showPageContent($content);
showPageFooter();

echo "</body></html>";
return;

/////////////////////////////////////////////////////////////////////

function navItem($selected, $url, $name, $icon = '')
{
    $active = $selected ? ' active' : '';
    $aria = $selected ? ' aria-current="page"' : '';
    $iconHtml = $icon ? '<i class="bi '.$icon.' me-1"></i>' : '';
    echo "<li class=\"nav-item\"><a class=\"nav-link$active\"$aria href=\"$url\">$iconHtml$name</a></li>";
}

function showPageHeader()
{
    $action = controller()->action->id;
    $wallet = user()->getState('yaamp-wallet');
    $ad = isset($_GET['address']);

    $mining = getdbosql('db_mining');
    $nextpayment = date('H:i T', $mining->last_payout+YAAMP_PAYMENTS_FREQ);
    $eta = ($mining->last_payout+YAAMP_PAYMENTS_FREQ) - time();
    $eta_mn = 'in '.max(0, round($eta / 60)).' minutes';

    echo '<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top border-bottom border-dark-subtle">';
    echo '  <div class="container-fluid">';
    echo '    <a class="navbar-brand fw-semibold" href="/">'.YAAMP_SITE_NAME.'</a>';
    echo '    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#yiimpNav" aria-controls="yiimpNav" aria-expanded="false" aria-label="Toggle navigation">';
    echo '      <span class="navbar-toggler-icon"></span>';
    echo '    </button>';
    echo '    <div class="collapse navbar-collapse" id="yiimpNav">';

    echo '      <ul class="navbar-nav me-auto mb-2 mb-lg-0">';
    navItem(controller()->id=='site' && $action=='index' && !$ad, '/', 'Home', 'bi-house');
    navItem($action=='mining', '/site/mining', 'Pool', 'bi-cpu');
    navItem(controller()->id=='site'&&($action=='index' || $action=='wallet') && $ad, "/?address=$wallet", 'Wallet', 'bi-wallet2');
    navItem(controller()->id=='stats', '/stats', 'Graphs', 'bi-graph-up');
    navItem($action=='miners', '/site/miners', 'Miners', 'bi-speedometer2');
    navItem(controller()->id=='api', '/site/api', 'API', 'bi-braces');

    if (defined('YIIMP_PUBLIC_EXPLORER') && YIIMP_PUBLIC_EXPLORER)
        navItem(controller()->id=='explorer', '/explorer', 'Explorers', 'bi-search');

    if (defined('YIIMP_PUBLIC_BENCHMARK') && YIIMP_PUBLIC_BENCHMARK)
        navItem(controller()->id=='bench', '/bench', 'Benchs', 'bi-bar-chart');

    if (defined('YAAMP_RENTAL') && YAAMP_RENTAL)
        navItem(controller()->id=='renting', '/renting', 'Rental', 'bi-truck');

    // Admin links
    if (defined('YIIMP_ADMIN_LOGIN') && YIIMP_ADMIN_LOGIN) {
        if(controller()->admin) {
            echo '<li class="nav-item dropdown">';
            echo '  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-shield-lock me-1"></i>Admin</a>';
            echo '  <ul class="dropdown-menu dropdown-menu-dark">';
            echo '    <li><a class="dropdown-item" href="/coin">Coins</a></li>';
            echo '    <li><a class="dropdown-item" href="/admin/dashboard">Dashboard</a></li>';
            echo '    <li><a class="dropdown-item" href="/admin/coinwallets">Wallets</a></li>';
            if (defined('YAAMP_RENTAL') && YAAMP_RENTAL)
                echo '    <li><a class="dropdown-item" href="/renting/admin">Jobs</a></li>';
            if (defined('YAAMP_ALLOW_EXCHANGE') && YAAMP_ALLOW_EXCHANGE)
                echo '    <li><a class="dropdown-item" href="/trading">Trading</a></li>';
            if (defined('YAAMP_USE_NICEHASH_API') && YAAMP_USE_NICEHASH_API)
                echo '    <li><a class="dropdown-item" href="/nicehash">Nicehash</a></li>';
            echo '    <li><hr class="dropdown-divider"></li>';
            echo '    <li><a class="dropdown-item" href="/admin/logout">Logout</a></li>';
            echo '  </ul>';
            echo '</li>';
        } else {
            navItem(controller()->id=='login', '/admin/login', 'Login', 'bi-box-arrow-in-right');
        }
    }

    echo '      </ul>';

    echo '      <div class="d-flex align-items-center gap-3">';
echo '        <button class="btn btn-sm btn-outline-light" id="yiimpThemeToggle" type="button" aria-label="Toggle theme"><i class="bi bi-moon-stars"></i></button>';
    echo '        <span class="text-body-secondary small d-none d-lg-inline" id="nextpayout" title="'.$eta_mn.'"><i class="bi bi-clock me-1"></i>Next payout: '.$nextpayment.'</span>';
    echo '      </div>';

    echo '    </div>';
    echo '  </div>';
    echo '</nav>';
}

function showPageContent($content)
{
    // Leave room for fixed navbar
    echo '<main class="container-fluid yiimp-main pt-4" style="margin-top: 3.5rem;">';
    echo $content;
    echo '</main>';

    // Bootstrap bundle
    echo '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>';
}

function showPageFooter()
{
    $year = date("Y", time());
    echo '<footer class="container-fluid py-4">';
    echo '  <div class="yiimp-footer text-center small text-body-secondary">';
    echo "    <div>&copy; $year ".YAAMP_SITE_NAME."</div>";
    echo '    <div class="mt-1">';
    echo '      <a class="link-secondary" href="https://github.com/Kudaraidee/yiimp" target="_blank" rel="noopener">Open source Project</a>';
    echo '      <span class="mx-2">•</span>';
    echo '      <a class="link-secondary" href="/site/api">API</a>';
    echo '    </div>';
    echo '  </div>';
    echo '</footer>';
}
