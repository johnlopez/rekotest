-------------------------------------------------------------------------------------------------
--ASIGNAR ROL A USUARIO--
use rekotest;
INSERT INTO usuario_administrador_has_rol_administrador (usuario_administrador_id,rol_administrador_id) 
SELECT UA.id,RA.id
FROM 	
		usuario_administrador UA,
        rol_administrador RA
WHERE  UA.id=3
AND RA.id=2;
-------------------------------------------------------------------------------------------------
--ASIGNAR PERMISO A USUARIO SEGUN EL ROL ASIGNADO
INSERT INTO authassignment (itemname,userid) 
SELECT AUTH.name, UA.id
FROM 
		usuario_administrador UA,
        usuario_administrador_has_rol_administrador UhasR,
        rol_administrador RA,
        rol_administrador_has_authitem RhasAUTH,
        authitem AUTH

WHERE UA.id = UhasR.usuario_administrador_id
AND RA.id = UhasR.rol_administrador_id
AND RhasAUTH.rol_administrador_id= RA.id
AND RhasAUTH.authitem_name = AUTH.name
AND RA.id=2



        
        