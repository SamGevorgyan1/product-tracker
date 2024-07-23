<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Create Store</title>
</head>
<body>
<h1>Create Store</h1>

<g:if test="${flash.message}">
    <div class="flash-message">
        ${flash.message}
    </div>
</g:if>

<g:form url="[controller: 'store', action: 'save']" method="POST">
    <fieldset>
        <legend>Store Details</legend>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${storeInstance?.name ?: ''}" required/>

        <legend>Address Details</legend>
        <label for="address">Address</label>
        <input type="text" name="address" id="address" value="${storeInstance?.address ?: ''}" required/>

        <button type="submit">Create</button>
    </fieldset>
</g:form>
</body>
</html>
