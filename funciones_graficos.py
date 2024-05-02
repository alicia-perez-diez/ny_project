def evolucion_crimenes_linear(df_principal):
    
    #pasamos el dataframe principal y devuelve el gráfico de líneas con la evolución de los crímenes por barrio entre los años 2016 y 2018

    import pandas as pd
    import seaborn as sns
    import matplotlib.pyplot as plt
    
    evolucion_crimenes = pd.melt(df_principal, id_vars='barrios', value_vars=['diferencia_crimenes_2016_2017', 'diferencia_crimenes_2017_2018'])

    sns.set_theme(style="darkgrid")

    plt.figure(figsize=(20, 10)) 

    sns.lineplot(x="variable", y="value", hue="barrios", data=evolucion_crimenes)

def promedio_crimenes_circular(df_crimenes_promedio):

    #pasamos el dataframe y devuelve el gráfico circular con el promedio de crímenes por barrio

    import plotly.express as px

    fig = px.pie(df_crimenes_promedio, values='crimenes_promedio', names='barrios', title="Promedio de crímenes por barrio")
    fig.show()

def promedio_crimenes_barras(df_crimenes_totales_promedio):

    #pasamos el dataframe y devuelve el gráfico de barras con el promedio y tipo de delitos por barrio

    import pandas as pd
    import plotly.express as px

    dataframe_grafico = pd.melt(df_crimenes_totales_promedio, id_vars='barrios', value_vars=['promedio_de_delitos',\
                                                                                             'promedio_de_faltas', 'promedio_de_violaciones'])

    fig = px.bar(dataframe_grafico, x='barrios', y='value', color='variable', hover_data=['barrios'], title='Promedio de crímenes por barrio')
    fig.show()

def promedio_precio_circular(df_precio_promedio):

    #pasamos el dataframe y devuelve el gráfico circular con el promedio de crímenes por barrio

    import plotly.express as px

    fig = px.pie(df_precio_promedio, values='promedio_de_precio', names='barrios', title="Promedio de precio por barrio")
    fig.show()

def promedio_reviews_circular(df_reviews_promedio):

    #pasamos el dataframe y devuelve el gráfico circular con el promedio de reviews por barrio

    import plotly.express as px

    fig = px.pie(df_reviews_promedio, values='promedio_de_reviews', names='barrios', title="Promedio de reviews por barrio")
    fig.show()

def relacion_precio_reviews_barras(df_principal):
    
    #pasamos el dataframe y devuelve el gráfico de barras con la relación entre precio y reviews por barrio
    
    import pandas as pd
    import plotly.express as px

    data_frame_relacion = pd.melt(df_principal, id_vars='barrios', value_vars=['precio_medio', 'num_medio_reviews'])

    fig = px.bar(data_frame_relacion, x='barrios', y='value', color='variable',
            hover_data=['barrios'],
            title='Relación entre el precio medio y el número de reviews por barrio')
    fig.show()