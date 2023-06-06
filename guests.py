import openpyxl
import pyperclip


# Load the Excel file
workbook = openpyxl.load_workbook(r"C:\Users\Oscar\OneDrive\BodaMexSept2023\InvitadosBodaMex2023.xlsx")
sheet = workbook['Hoja1']

# Get the maximum number of rows in the sheet
max_rows = sheet.max_row

# Start with row index 2 to skip the header row
current_row = 2
# Clear the previous row's values
print('\033c', end='')
while current_row <= max_rows:
    # Get the values of the desired columns
    saludo = sheet[f'A{current_row}'].value
    nombre = sheet[f'B{current_row}'].value
    apellidos = sheet[f'C{current_row}'].value
    telefono = sheet[f'D{current_row}'].value
    mensaje = f"""¡Hola {saludo}!

Nos complace invitarte/les a nuestra boda y al bautizo de nuestra querida hija Olivia que celebraremos el día 23 de Septiembre en la Parroquia de San Juan Bautista, en Huasca, Hidalgo.

Para conocer todos los detalles y confirmar tu assistencia entra a bit.ly/boda-MyO

Atentamente,
Marychu Dayao y Oscar López Veloz"""
    if not telefono is None:
        # Print the values

        print("Nombre:", nombre)
        print("Apellidos:", apellidos)
        print("Teléfono:", telefono)
        print("Saludo:", saludo)
        #print("Mensaje:", mensaje)
        
        # Copy the mensaje value to the clipboard
        pyperclip.copy(mensaje)
        
        # Wait for user input to proceed to the next row
        input("Press Enter to continue...")
        
        # Clear the previous row's values
    print('\033c', end='')
    
    # Move to the next row
    current_row += 1

# Close the workbook
workbook.close()
