<!DOCTYPE html>
<html>
<head>
    <title>Storages</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
        color: #333;
    }
    .container {
        width: 80%;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 30px auto 0;
    }
    h1 {
        color: #4CAF50;
    }
    a, button {
        text-decoration: none;
        font-size: 1em;
        display: inline-block;
        background-color: #45a049;
        color: white;
        padding: 10px 15px;
        border-radius: 4px;
        margin-bottom: 20px;
        border: none;
        cursor: pointer;
    }
    a:hover, button:hover {
        background-color: #388e3c;
        text-decoration: none;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
    .actions button {
        margin-right: 10px;
        color: white;
        background-color: #45a049;
        padding: 5px 10px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
    }
    .actions button:hover {
        background-color: #388e3c;
    }
    .delete {
        background-color: #e74c3c;
    }
    .delete:hover {
        background-color: #c0392b;
    }
    </style>
</head>
<body>
<div class="container">
    <h1>Storages</h1>
    <a href="${createLink(controller: 'storage', action: 'create')}">Add New Storage</a>

    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${storages}" var="storage">
            <tr>
                <td>${storage.name}</td>
                <td class="actions">
                    <a href="${createLink(controller: 'storage', action: 'edit', id: storage.id)}">Edit</a>
                    <form action="${createLink(controller: 'storage', action: 'delete', id: storage.id)}" method="post" style="display:inline;">
                        <input type="hidden" name="_method" value="delete"/>
                        <button type="submit" class="delete" onclick="return confirm('Are you sure you want to delete this storage?');">Delete</button>
                    </form>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
</body>
</html>
