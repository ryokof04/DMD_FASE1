import tkinter as tk
from tkinter import messagebox
from tkinter import ttk
from tkcalendar import Calendar
import pyodbc
import pandas as pd
import webbrowser

# Función para abrir el reporte de Power BI en el navegador
def abrir_reporte_power_bi():
    url_reporte = "https://app.powerbi.com/groups/me/reports/126ad49f-68ee-4689-88e2-ecadff6f83ae/0c9f839f202c4081f756?experience=power-bi"
    webbrowser.open(url_reporte)

# Función para centrar la ventana
def centrar_ventana(ventana, ancho, alto):
    pantalla_ancho = ventana.winfo_screenwidth()
    pantalla_alto = ventana.winfo_screenheight()
    x = (pantalla_ancho // 2) - (ancho // 2)
    y = (pantalla_alto // 2) - (alto // 2)
    ventana.geometry(f'{ancho}x{alto}+{x}+{y}')

# Función para generar el reporte de ventas
def generar_reporte_ventas():
    limpiar_frame()
    root.geometry("800x600")
    centrar_ventana(root, 800, 600)

    tk.Label(root, text="Fecha de inicio:").pack(pady=5)
    global cal_inicio
    cal_inicio = Calendar(root, selectmode='day', year=2024, month=10, day=1)
    cal_inicio.pack(pady=5)

    tk.Label(root, text="Fecha de fin:").pack(pady=5)
    global cal_fin
    cal_fin = Calendar(root, selectmode='day', year=2024, month=10, day=31)
    cal_fin.pack(pady=5)

    btn_generar = tk.Button(root, text="Generar Reporte de Ventas", command=mostrar_tabla_ventas)
    btn_generar.pack(pady=10)

    global tabla
    cols = ('Producto', 'Total Ventas')
    tabla = ttk.Treeview(root, columns=cols, show='headings')
    for col in cols:
        tabla.heading(col, text=col)
    tabla.pack(pady=10)

    btn_volver_menu = tk.Button(root, text="Regresar al Menú Principal", command=volver_al_menu)
    btn_volver_menu.pack(pady=10)

# Función para generar el reporte de incremento
def generar_reporte_incremento():
    limpiar_frame()
    root.geometry("800x600")
    centrar_ventana(root, 800, 600)

    tk.Label(root, text="Fecha de inicio:").pack(pady=5)
    global cal_inicio
    cal_inicio = Calendar(root, selectmode='day', year=2024, month=10, day=1)
    cal_inicio.pack(pady=5)

    tk.Label(root, text="Fecha de fin:").pack(pady=5)
    global cal_fin
    cal_fin = Calendar(root, selectmode='day', year=2024, month=10, day=31)
    cal_fin.pack(pady=5)

    btn_generar = tk.Button(root, text="Generar Reporte de Incremento", command=mostrar_tabla_incremento)
    btn_generar.pack(pady=10)

    global tabla
    cols = ('Producto', 'Mes Actual', 'Ventas Actuales', 'Ventas Anteriores', 'Incremento (%)')
    tabla = ttk.Treeview(root, columns=cols, show='headings')
    for col in cols:
        tabla.heading(col, text=col)
    tabla.pack(pady=10)

    btn_volver_menu = tk.Button(root, text="Regresar al Menú Principal", command=volver_al_menu)
    btn_volver_menu.pack(pady=10)

# Función para llenar la tabla con los datos del incremento
def mostrar_tabla_incremento():
    fecha_inicio = cal_inicio.get_date()
    fecha_fin = cal_fin.get_date()

    query = f"""
    SELECT
        dp.nombre_producto AS producto,
        dt_actual.nombre_mes AS mes_actual,
        SUM(hv_actual.ventas_netas) AS ventas_actuales,
        SUM(hv_anterior.ventas_netas) AS ventas_anteriores,
        CASE 
            WHEN SUM(hv_anterior.ventas_netas) = 0 THEN 0 
            ELSE (SUM(hv_actual.ventas_netas) - SUM(hv_anterior.ventas_netas)) / SUM(hv_anterior.ventas_netas) * 100
        END AS incremento_porcentual
    FROM 
        hecho_ventas hv_actual
    JOIN 
        dim_producto dp ON hv_actual.id_producto = dp.id_producto
    JOIN 
        dim_tiempo dt_actual ON hv_actual.id_tiempo = dt_actual.id_fecha
    LEFT JOIN 
        hecho_ventas hv_anterior ON hv_actual.id_producto = hv_anterior.id_producto
    JOIN 
        dim_tiempo dt_anterior ON hv_anterior.id_tiempo = dt_anterior.id_fecha
        AND dt_anterior.anio = dt_actual.anio - 1
        AND dt_anterior.numero_mes = dt_actual.numero_mes
    WHERE 
        dt_actual.fecha >= '{fecha_inicio}' AND dt_actual.fecha <= '{fecha_fin}'
    GROUP BY 
        dp.nombre_producto, dt_actual.nombre_mes
    ORDER BY 
        producto, dt_actual.nombre_mes;
    """

    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                          r'SERVER=DESKTOP-7VMPCQ8\MSSQLSERVER_VEGA;'
                          'DATABASE=FASE1;'
                          'Trusted_Connection=yes;')
    df = pd.read_sql(query, conn)
    conn.close()

    if df.empty:
        messagebox.showerror("Error", "No se encontraron datos para las fechas seleccionadas.")
        return

    for i in tabla.get_children():
        tabla.delete(i)

    for index, row in df.iterrows():
        tabla.insert("", tk.END, values=(row['producto'], row['mes_actual'], row['ventas_actuales'], row['ventas_anteriores'], f"{row['incremento_porcentual']:.2f}%"))

# Función para llenar la tabla con los datos de ventas
def mostrar_tabla_ventas():
    fecha_inicio = cal_inicio.get_date()
    fecha_fin = cal_fin.get_date()

    query = f"""
    SELECT dp.nombre_producto AS producto, SUM(hv.ventas_netas) AS total_ventas
    FROM hecho_ventas hv
    JOIN dim_producto dp ON hv.id_producto = dp.id_producto
    JOIN dim_tiempo dt ON hv.id_tiempo = dt.id_fecha
    WHERE dt.fecha >= '{fecha_inicio}' AND dt.fecha <= '{fecha_fin}'
    GROUP BY dp.nombre_producto;
    """

    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                          r'SERVER=DESKTOP-7VMPCQ8\MSSQLSERVER_VEGA;'
                          'DATABASE=FASE1;'
                          'Trusted_Connection=yes;')
    df = pd.read_sql(query, conn)
    conn.close()

    for i in tabla.get_children():
        tabla.delete(i)

    for index, row in df.iterrows():
        tabla.insert("", tk.END, values=(row['producto'], row['total_ventas']))

# Función para limpiar la ventana principal
def limpiar_frame():
    for widget in root.winfo_children():
        widget.pack_forget()

# Función para volver al menú principal
def volver_al_menu():
    limpiar_frame()
    root.geometry("400x300")
    centrar_ventana(root, 400, 300)
    mostrar_menu()

# Función para mostrar el menú principal
def mostrar_menu():
    label = tk.Label(root, text="Seleccione el tipo de reporte")
    label.pack(pady=10)

    btn_reporte_ventas = tk.Button(root, text="Reporte de Ventas", command=generar_reporte_ventas)
    btn_reporte_ventas.pack(pady=5)

    btn_reporte_incremento = tk.Button(root, text="Reporte de Incremento", command=generar_reporte_incremento)
    btn_reporte_incremento.pack(pady=5)

    btn_reporte_power_bi = tk.Button(root, text="Abrir Reporte de Power BI", command=abrir_reporte_power_bi)
    btn_reporte_power_bi.pack(pady=5)

# Crear la ventana principal
root = tk.Tk()
root.title("Generador de Reportes")
root.geometry("400x300")

centrar_ventana(root, 400, 300)
mostrar_menu()

root.mainloop()





