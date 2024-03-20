# Purpose
The purpose of this is to preview a rendered liquid template file combined with data inside vscode.

# Steps

### At first install these 2 extensions in vscode

[Shopify Liquid Preview](https://marketplace.visualstudio.com/items?itemName=kirchner-trevor.shopify-liquid-preview)

[HTML Preview](https://marketplace.visualstudio.com/items?itemName=george-alisson.html-preview-vscode)

### Create a html file `index.html` with the code.
```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Preview Liquid Template Instantly in vscode</title>
</head>

<body>
    <div style="width:100%; text-align: center;">
        <h1>Greetings from {{name}}</h1>
        <h2>{{post.title}}</h2>
        <h3>{{post.description}}</h3>
        {%- if conditional.enabled -%}
        <p>This section is only visible when conditional is enabled</p>
        {%- endif -%}
    </div>
</body>

</html>
```

### Create a `data.json` file to connect with the html file
```
{
  "name": "Minhazul Hayat Khan",
  "post": {
    "title": "Preview Liquid Template instantly in vscode",
    "description": "This uses 2 vscode extensions to directly preview the liquid template with data connected"
  },
  "conditional": {
    "enabled": true
  }
}

```

### Press `CTRL + SHIFT + P` and select `Shopify Liquid: Open Preview to the side` option and select the `data.json` file
![select open preview to the side](<images/01. select open preview to the side.png>)

![connect data.json](<images/02. connect data.json.png>)

### It should open a preview with the html file connected with the data. Click on the window and press `CTRL + SHIFT + P` again and select the `HTML: Open Preview` option

![select the generated html file and select open preview](<images/03. compiled html file with the data.png>)

### This should generate the necessary html preview.

![Generated html file](<images/04. render the html file in vscode.png>)

## References
1. [Shopify Liquid Preview](https://marketplace.visualstudio.com/items?itemName=kirchner-trevor.shopify-liquid-preview)

2. [HTML Preview](https://marketplace.visualstudio.com/items?itemName=george-alisson.html-preview-vscode)
