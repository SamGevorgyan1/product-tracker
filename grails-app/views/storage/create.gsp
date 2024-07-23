<!DOCTYPE html>
<html>
<head>
    <title>Create Storage</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
        color: #333;
    }
    .container {
        width: 50%;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 30px auto 0;
    }
    h1 {
        color: #4CAF50;
    }
    .message, .error {
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 4px;
    }
    .message {
        background-color: #d4edda;
        color: #155724;
    }
    .error {
        background-color: #f8d7da;
        color: #721c24;
    }
    fieldset {
        border: none;
        margin: 0;
        padding: 0;
    }
    legend {
        font-size: 1.2em;
        margin-bottom: 10px;
        color: #4CAF50;
    }
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    input[type="text"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="submit"] {
        background-color: #45a049;
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1em;
    }
    input[type="submit"]:hover {
        background-color: #388e3c;
    }
    a {
        color: #4CAF50;
        text-decoration: none;
        font-size: 1em;
    }
    a:hover {
        text-decoration: underline;
    }
    </style>
</head>
<body>
<div class="container">
    <h1>Create Storage</h1>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>

    <g:if test="${flash.error}">
        <div class="error">${flash.error}</div>
    </g:if>

    <g:form controller="storage" action="save">
        <fieldset>
            <legend>Storage Details</legend>
            <label for="name">Name:</label>
            <g:textField name="name" id="name" />
            <br/>
            <input type="submit" value="Save" />
        </fieldset>
    </g:form>

    <a href="${createLink(controller: 'storage', action: 'index')}">Back to List</a>
</div>
</body>
</html>
