import os
import mysql.connector

# File directory
config_dir = os.path.expandvars('%userprofile%/documents/freelit/mzr/config')

# Find the text file in the config directory
txt_files = [file for file in os.listdir(config_dir) if file.endswith('.txt')]
if len(txt_files) == 0:
    print("No text file found in the config directory.")
    exit()

# Assuming only one text file exists, we take the first one
file_path = os.path.join(config_dir, txt_files[0])
terminal_id = os.path.splitext(txt_files[0])[0]

# Read the connection string from the file
with open(file_path, 'r') as file:
    connection_string = file.read().strip()

# Establish a MySQL connection
conn = mysql.connector.connect(connection_string)

# Create a cursor
cursor = conn.cursor()

# SQL DDL statement to create the table if not exists
create_table_statement = """
CREATE TABLE IF NOT EXISTS configuration_parameters (
    terminal_id INT NOT NULL,
    parameter_name VARCHAR(255) NOT NULL,
    parameter_value VARCHAR(255) NOT NULL,
    parameter_type VARCHAR(255) NOT NULL,
    start_dt DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_dt DATETIME
);
"""
# SQL statements
delete_statement = f"DELETE FROM configuration_parameters WHERE terminal_id = {terminal_id};"

insert_statement = f"""
INSERT INTO configuration_parameters (terminal_id, parameter_name, parameter_value, parameter_type)
VALUES
    ({terminal_id}, 'Id_Tienda', '1', 'System.Int32'),
    ({terminal_id}, 'IVA_Factor', '0', 'System.Decimal'),
    ({terminal_id}, 'MargenUDefault', '50', 'System.Decimal'),
    ({terminal_id}, 'LE_RegistroUnoXUno', 'False', 'System.Boolean'),
    ({terminal_id}, 'LE_CANTIDAD_PAQUETE_DEFAULT', '1', 'System.Int32'),
    ({terminal_id}, 'Id_Bodega', '1', 'System.Int32'),
    ({terminal_id}, 'Imp_Facturas', '', 'System.String'),
    ({terminal_id}, 'Imp_Tickets', 'Microsoft Print to PDF', 'System.String'),
    ({terminal_id}, 'Imp_Etiquetas', '', 'System.String'),
    ({terminal_id}, 'descuento_automatico', '0', 'System.Decimal'),
    ({terminal_id}, 'tipo_etiqueta_default', '1', 'System.Int32'),
    ({terminal_id}, 'tipo_calculoprecio', '1', 'System.Int32'),
    ({terminal_id}, 'esperar_vendedor', 'True', 'System.Boolean'),
    ({terminal_id}, 'copia_vendedor', 'False', 'System.Boolean'),
    ({terminal_id}, 'tipo_precio', '1', 'System.Int32'),
    ({terminal_id}, 'control_generico_default', 'False', 'System.Boolean'),
    ({terminal_id}, 'largo_tkt_mm', '350', 'System.Int32'),
    ({terminal_id}, 'etapa_migracion', 'False', 'System.Boolean'),
    ({terminal_id}, 'IsDbUpdater', 'True', 'System.Boolean'),
    ({terminal_id}, 'descTempPorcentaje', '0', 'System.Decimal'),
    ({terminal_id}, 'bkp_tiempo_mins', '2', 'System.Int32'),
    ({terminal_id}, 'bkp_hacerRespaldos', 'False', 'System.Boolean'),
    ({terminal_id}, 'bkp_archivoRespaldo', 'backup_mzr.sql', 'System.String'),
    ({terminal_id}, 'bs_issyncer', 'False', 'System.Boolean'),
    ({terminal_id}, 'bs_syncOutFilePath', '', 'System.String'),
    ({terminal_id}, 'bs_syncInFilePath', '', 'System.String'),
    ({terminal_id}, 'descTempNombre', '', 'System.String'),
    ({terminal_id}, 'porcentaje_pago_tarjeta', '0', 'System.Decimal');
"""
# Execute the DDL statement to create the table
cursor.execute(create_table_statement)
# Execute the SQL statements
cursor.execute(delete_statement)
cursor.execute(insert_statement)

# Commit the changes
conn.commit()

# Close the cursor and connection
cursor.close()
conn.close()

# Print the terminal_id
print("Terminal ID:", terminal_id)
