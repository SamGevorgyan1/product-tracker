<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Stores</title>
</head>

<body>
<h1>Stores</h1>
<a href="${createLink(controller: 'store', action: 'create')}">Add New Store</a>
<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>Address</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${stores}" var="store">
        <tr>
            <td>${store.name}</td>
            <td>${store.address}</td>
            <td>
                <a href="${createLink(controller: 'store', action: 'show', id: store.id)}">Edit</a> |
                <a href="${createLink(controller: 'store', action: 'delete', id: store.id)}"
                   onclick="return confirm('Are you sure?');">Delete</a> |
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
</body>
</html>
