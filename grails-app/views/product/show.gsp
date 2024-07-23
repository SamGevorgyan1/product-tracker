<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.title}</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    h1 {
        color: #333;
    }
    dl {
        margin-top: 20px;
    }
    dt {
        font-weight: bold;
        margin-top: 10px;
    }
    dd {
        margin-left: 20px;
        margin-bottom: 10px;
    }
    .actions {
        margin-top: 10px;
    }
    .back-link {
        display: inline-block;
        margin-top: 10px;
        text-decoration: none;
        color: #007bff;
    }
    .back-link:hover {
        text-decoration: underline;
    }
    </style>
</head>
<body>
<h1>Show Product ${product.title}</h1>
<dl>
    <dt>Barcode: ${product.barcode}</dt>
    <dt>Title: ${product.title}</dt>
    <dt>Price: ${product.price}</dt>
    <dt>Production Date: ${product.creationDate ?: '-'}</dt>
    <dt>Deadline: ${product.deadline ?: '-'}</dt>
</dl>
<div class="actions">
    <g:link action="edit" id="${product.id}">Edit</g:link> |
    <a href="${createLink(action: 'index')}" class="back-link">Back to List</a>
</div>
</body>
</html>
