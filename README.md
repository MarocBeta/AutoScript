## Maroc Beta AutoScript
<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=22&duration=3000&pause=1000&color=F75C7E&center=true&vCenter=true&width=435&lines=Hi+there!+%F0%9F%91%8B;I'm+Maroc+Beta;Welcome+to+my+profile!" alt="Typing SVG" />
</p>

<p align="center">
  <img src="Banner/Welcome.jpeg" width="100%">
</p>

<p align="center">
  <img src="Banner/Menu.jpeg" width="100%">
</p>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Service & Port</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding: 30px;
    background: #111526;
    color: #12a58d;
    font-family: "Courier New", monospace;
    font-weight: bold;
}

.container {
    max-width: 1100px;
    margin: auto;
}

.title {
    font-size: 32px;
    margin-bottom: 12px;
}

.row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 28px;
    line-height: 1.7;
}

.service::before {
    content: "- ";
}

.port {
    min-width: 280px;
}

@media (max-width: 700px) {
    body {
        padding: 15px;
    }

    .title {
        font-size: 20px;
    }

    .row {
        font-size: 15px;
        line-height: 2;
    }

    .port {
        min-width: 135px;
    }
}
</style>
</head>

<body>

<div class="container">

    <div class="title">
        &gt;&gt;&gt; Service &amp; Port
    </div>

    <div class="row">
        <span class="service">Open SSH</span>
        <span class="port">: 443, 80, 22</span>
    </div>

    <div class="row">
        <span class="service">Dropbear</span>
        <span class="port">: 109, 143</span>
    </div>

    <div class="row">
        <span class="service">SSH Websocket SSL</span>
        <span class="port">: 443</span>
    </div>

    <div class="row">
        <span class="service">SSH Websocket HTTP</span>
        <span class="port">: 80</span>
    </div>

    <div class="row">
        <span class="service">SSH UDP Custom</span>
        <span class="port">: 1-65535</span>
    </div>

    <div class="row">
        <span class="service">OpenVPN TCP</span>
        <span class="port">: 1194</span>
    </div>

    <div class="row">
        <span class="service">OpenVPN UDP</span>
        <span class="port">: 2200</span>
    </div>

    <div class="row">
        <span class="service">OpenVPN SSL</span>
        <span class="port">: 990</span>
    </div>

    <div class="row">
        <span class="service">XRAY Vmess TLS</span>
        <span class="port">: 443</

### Install :

```
apt update -y && apt upgrade -y && apt install -y screen && wget -q https://raw.githubusercontent.com/MarocBeta/AutoScript/main/setup.sh && chmod +x setup.sh && screen -S RS ./setup.sh
```
### Update :

```
wget -q https://raw.githubusercontent.com/MarocBeta/AutoScript/main/update.sh && chmod +x update.sh && ./update.sh
```

## BotPanel.

### Install :

```
wget -q https://raw.githubusercontent.com/MarocBeta/BotPanel/main/install.sh && chmod +x install.sh && ./install.sh
```
