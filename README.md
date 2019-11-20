This image contains LogoControl from frickelzeugs.de and nginx for reverse proxy.
<br>
Available commands for nginx base authentication (optional, if not set, it will not be protected):<br>
<ul>
<li>-e AUTH_USER=admin</li><li>-e AUTH_PASS=XXX</li>
</ul>

Make config.xml persistent, create volume and map to /opt/LogoControl/data<br>
e.g.<br>
docker create volume LogoControl<br>
docker run ... -v LogoControl:/opt/LogoControl/data<br>
