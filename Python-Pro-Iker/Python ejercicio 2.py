import random
Contrasena = ""
Nombre = input("Escribe su nombre (Será incluido en su contraseña)")
print ("Soy un generador de contraseñas")
Caracter = "1!23·4$5%6&7/8)(9=?'¡¿qQwWeErRtTyYuUiIoOpP`^+*aAssdDfFgGhHjJkKlLñÑ¨<>zZxXcCvVBbnNmM,;."
Longitud = int(input("Elige la mitad de la longitud que tendra la contraseña (Cuantos caracteres tendrá)"))
for i in range(Longitud):
    Generador = random.choice(Caracter)
    Contrasena = Contrasena + Generador
Contrasena = Contrasena + Nombre
for i in range(Longitud):
    Generador = random.choice(Caracter)
    Contrasena = Contrasena + Generador
print (Contrasena, "Esta es tu nueva contraseña")