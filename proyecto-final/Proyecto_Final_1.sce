clear
///////////////////////////////////////////////////////
//  Proyecto_Final_1.sce
//
//
//   Armando Roque A01138717
//   Marco Brown Cunningham 
//
//   16 / Noviembre  / 2019    version 1.0
//////////////////////////////////////////////////////

// leer valores del excel
function iMatValues = GetExcelValues()
    // pide al usuario que seleccione el archivo
    sExcelName = uigetfile("*.xls")
    disp(sExcelName)
    // lee las hojas del excel
    dSheets = readxls(sExcelName)
    // lee la primera hoja del excel
    dSheet1 = dSheets(1)
    // la matriz almacena los valores de las x y las y
    iMatValues = dSheet1( : , 1 : 2)
endfunction

// Montante

//////////////////////////////////////////////////////
//  Montante
//
//  Funcion que imprime la matriz transformada y los
//resultados de las incognitas de la matriz
//   Parametros:
//      matMon la matriz a transformar
//   Regresa:
//     iArrRegression un arreglo con las respuestas
/////////////////////////////////////////////////////
function iArrRegression = Montante(matMon)
    iPivAnt=1
    //empieza en uno porque no existe uno anterior
    for iRen=1:size(matMon,1)
        //se realiza el pivoteo con todos los renglones
        for iK=1:size(matMon,1)
            //se toma un renglon K con el que se pivotean los demas
            if(iK<>iRen)
                //el renglon del valor K actual no cambia
                for iCol=iRen+1:size(matMon,2)
                    //se toman los valores desde el renglon +1 porque los otros ya se han tomado en cuenta.
                    matMon(iK,iCol)=(matMon(iRen,iRen)*matMon(iK,iCol)-matMon(iK,iRen)*matMon(iRen,iCol))/iPivAnt
                    //se realizan los determinantes entre el pivote anterior
                end
                matMon(iK,iRen)=0
                //los demas de la columna se transforman a 0
             end
        end
        iPivAnt=matMon(iRen,iRen)
        //el pivote anterior cambia por el renglon K
    end
    for(iRen=1:size(matMon,1)-1)
        //el ultimo pivote anterior toma las posiciones de los demas repitiendose
        matMon(iRen,iRen)=iPivAnt
    end
    for iRen=1:size(matMon,1)
        //se expresan los resultados 
        iArrRegression(iRen)=matMon(iRen,size(matMon,2))/iPivAnt
    end
endfunction



// funcion que te regresa los valores que ocupas
// 1- Lineal
// 2- Cuadratica
// 3- Exponencial
// 4- Potencia
function iArrParams = GetParamsRegression(iMatValues, iType)
    // numero de elementos (renglones)
    iN = size(iMatValues, 1)
    iArrParams(1) = iN

    if (iType < 4) then
        // sumatoria de X's
        iSumX = 0
        for (iRen = 1 : iN)
            iSumX = iSumX + iMatValues(iRen, 1)
        end
        iArrParams(2) = iSumX

        // sumatoria de X^2s
        iSumX2 = 0
        for (iRen = 1 : iN)
            iSumX2 = iSumX2 + (iMatValues(iRen, 1)) ^ 2
        end
        iArrParams(3) = iSumX2

        if (iType < 3) then
            // sumatoria de Y's
            iSumY = 0
            for (iRen = 1 : iN)
                iSumY = iSumY + iMatValues(iRen, 2)
            end

            // sumatoria de (X * Y)'s
            iSumXY = 0
            for (iRen = 1 : iN)
                iSumXY = iSumXY + (iMatValues(iRen, 1) * iMatValues(iRen, 2))
            end

            if (iType == 1) then
                iArrParams(4) = iSumY
                iArrParams(5) = iSumXY
            else
                // es de tipo 2 (cuadratica)
                // sumatoria de X^3s
                iSumX3 = 0
                for (iRen = 1 : iN)
                    iSumX3 = iSumX3 + (iMatValues(iRen, 1)) ^ 3
                end
                iArrParams(4) = iSumX3

                // sumatoria de X^4s
                iSumX4 = 0
                for (iRen = 1 : iN)
                    iSumX4 = iSumX4 + (iMatValues(iRen, 1)) ^ 4
                end
                iArrParams(5) = iSumX4

                iArrParams(6) = iSumY

                iArrParams(7) = iSumXY

                // sumatoria de (X^2 * Y)'s
                iSumX2Y = 0
                for (iRen = 1 : iN)
                    iSumX2Y = iSumX2Y + ((iMatValues(iRen, 1) ^2) * iMatValues(iRen, 2))
                end
                iArrParams(8) = iSumX2Y

            end
        else 
            // es tipo 3 (exponencial)
            // sumatoria de ln(Y)'s
            iSumLnY = 0
            for (iRen = 1 : iN)
                iSumLnY = iSumLnY + log(iMatValues(iRen, 2))
            end
            iArrParams(4) = iSumLnY

            // sumatoria de ln(Y) * X
            iSumLnY_X = 0
            for (iRen = 1 : iN)
                iSumLnY_X = iSumLnY_X + (log(iMatValues(iRen, 2)) * iMatValues(iRen, 1))
            end
            iArrParams(5) = iSumLnY_X

        end

    else
        // es de tipo 4 (potencia)
        // sumatoria de ln(X)'s
        iSumLnX = 0
        for (iRen = 1 : iN)
            iSumLnX = iSumLnX + log(iMatValues(iRen, 1))
        end
        iArrParams(2) = iSumLnX

        // sumatoria de ln(X)^2's
        iSumLnX2 = 0
        for (iRen = 1 : iN)
            iSumLnX2 = iSumLnX2 + (log(iMatValues(iRen, 1)) ^ 2)
        end
        iArrParams(3) = iSumLnX2

        // sumatoria de ln(Y)'s
        iSumLnY = 0
        for (iRen = 1 : iN)
            iSumLnY = iSumLnY + log(iMatValues(iRen, 2))
        end
        iArrParams(4) = iSumLnY

        // sumatoria de ln(Y) * ln(X)
        iSumLnYLnX = 0
        for (iRen = 1 : iN)
            iSumLnYLnX = iSumLnYLnX + (log(iMatValues(iRen, 2)) * log(iMatValues(iRen, 1)))
        end
        iArrParams(5) = iSumLnYLnX

    end
endfunction

// regresion lineal
function iArrRegLineal = GetRegLineal(iMatValues)
    // generar matriz a transformar para mandar a Montante
    iArrParams = GetParamsRegression(iMatValues, 1)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // X
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // X^2
    iMatMontanteParam(2, 2) = iArrParams(3)
    // Y
    iMatMontanteParam(1, 3) = iArrParams(4)
    // XY
    iMatMontanteParam(2, 3) = iArrParams(5)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegLineal = Montante(iMatMontanteParam)

endfunction

// regresion cuadratica
function iArrRegCuadratica = GetRegCuadratica(iMatValues)
    iArrParams = GetParamsRegression(iMatValues, 2)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // X
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // X^2
    iCol = 3
    for iRen = 1 : 3 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(3)
        iCol = iCol - 1
    end
    // X^3
    iCol = 3
    for iRen = 2 : 3 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(4)
        iCol = iCol - 1
    end
    // X^4
    iMatMontanteParam(3, 3) = iArrParams(5)
    // Y
    iMatMontanteParam(1, 4) = iArrParams(6)
    // XY
    iMatMontanteParam(2, 4) = iArrParams(7)
    // Y*X^2
    iMatMontanteParam(3, 4) = iArrParams(8)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegCuadratica = Montante(iMatMontanteParam)
endfunction

// regresion exponencial
function iArrRegExponencial = GetRegExponencial(iMatValues)
    iArrParams = GetParamsRegression(iMatValues, 3)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // X
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // X^2
    iMatMontanteParam(2, 2) = iArrParams(3)
    // ln(Y)
    iMatMontanteParam(1, 3) = iArrParams(4)
    // ln(Y)*X
    iMatMontanteParam(2, 3) = iArrParams(5)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegExponencial = Montante(iMatMontanteParam)
    // ajustar el valor del termino constante con exponencial
    iArrRegExponencial(1) = exp(iArrRegExponencial(1))
endfunction

// regresion potencia
function iArrRegPotencia = GetRegPotencia(iMatValues)
    iArrParams = GetParamsRegression(iMatValues, 4)

    // acomodar valores en la matriz adecuada
    // N
    iMatMontanteParam(1, 1) = iArrParams(1)
    // ln(X)
    iCol = 2
    for iRen = 1 : 2 // el numero de renglones
        iMatMontanteParam(iRen, iCol) = iArrParams(2)
        iCol = iCol - 1
    end
    // ln(X)^2
    iMatMontanteParam(2, 2) = iArrParams(3)
    // ln(Y)
    iMatMontanteParam(1, 3) = iArrParams(4)
    // ln(Y)*ln(X)
    iMatMontanteParam(2, 3) = iArrParams(5)

    // llamar a Montante y que regrese la matriz con las respuestas
    iArrRegPotencia = Montante(iMatMontanteParam)
    // ajustar el valor del termino constante con exponencial
    iArrRegPotencia(1) = exp(iArrRegPotencia(1))
endfunction


// calcular r^2
function iArrRegR2 = GetR2(iMatValues, iArrRegressions)
    dMejorReg = 0
    global dNumMejor
    dNumMejor = 0
    iN = size(iMatValues, 1)
    dYMean = mean(iMatValues(:, 2))
    dYLog = log(iMatValues(:, 2))
    dYLogMean = mean(dYLog)

    dSSTot = 0
    dSSTotLog = 0
    dSSRegLin = 0
    dSSRegCuad = 0
    dSSRegExp = 0
    dSSRegPot = 0
    for i = 1 : iN
        dSSTot = dSSTot + (iMatValues(i, 2) - dYMean) ^ 2
        dSSTotLog = dSSTotLog + (dYLog(i) - dYLogMean) ^ 2
        dSSRegLin = dSSRegLin + (iMatValues(i, 2) - iArrRegressions(1).regFunc(iMatValues(i, 1))) ^ 2
        dSSRegCuad = dSSRegCuad + (iMatValues(i, 2) - iArrRegressions(2).regFunc(iMatValues(i, 1))) ^ 2
        dSSRegExp = dSSRegExp + (log(iMatValues(i, 2)) - log(iArrRegressions(3).regFunc(iMatValues(i, 1)))) ^ 2
        dSSRegPot = dSSRegPot + (log(iMatValues(i, 2)) - log(iArrRegressions(4).regFunc(iMatValues(i, 1)))) ^ 2
    end

    iArrRegressions(1).r2 = 1 - dSSRegLin / dSSTot
    iArrRegressions(2).r2 = 1 - dSSRegCuad / dSSTot
    iArrRegressions(3).r2 = 1 - dSSRegExp / dSSTotLog
    iArrRegressions(4).r2 = 1 - dSSRegPot / dSSTotLog
    iArrRegR2 = iArrRegressions
    //disp(iArrRegressions(1).regParams(1))
    linealstring= "y= ("+string(iArrRegressions(1).regParams(1))+") +("+string(iArrRegressions(1).regParams(2))+")*x"
    cuadraticastring="y= ("+string(iArrRegressions(2).regParams(1))+") +("+string(iArrRegressions(2).regParams(2))+")*x("+string(iArrRegressions(2).regParams(3))+")*x^2"
    exponencialstring="y= ("+string(iArrRegressions(3).regParams(1))+")*e^ ("+string(iArrRegressions(3).regParams(2))+")*x"
    potenciastring="y= ("+string(iArrRegressions(4).regParams(1))+")*x^ ("+string(iArrRegressions(4).regParams(2))+")"
    params = [" " "y" "r^2" ];
    towns = ["Lineal" "Cuadrático" "Exponencial" "Potencia"]';
    pop  = [linealstring cuadraticastring exponencialstring potenciastring]';
    //pop  = string([22.41 11.77 33.41 4.24]');
    temp = string([iArrRegR2(1).r2 iArrRegR2(2).r2 iArrRegR2(3).r2 iArrRegR2(4).r2]');
    table = [params; [ towns pop temp ]]
    handles.tablaModelos=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.2022727,0.5,0.2],'Relief','default','SliderStep',[0.01,0.1],'String',table,'Style','table','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','tablaModelos','Callback','tablaModelos_callback(handles)')
    for(i=1:4)
        if(dMejorReg < iArrRegR2(i).r2)
            dMejorReg=iArrRegR2(i).r2
            dNumMejor = i
        end
    end
    select dNumMejor
    case 1 then
        handles.mejorModelo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.0045455,0.5,0.0954545],'Relief','default','SliderStep',[0.01,0.1],'String','Lineal','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','mejorModelo','Callback','')
    case 2 then
        handles.mejorModelo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.0045455,0.5,0.0954545],'Relief','default','SliderStep',[0.01,0.1],'String','Cuadratica','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','mejorModelo','Callback','')
    case 3 then
        handles.mejorModelo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.0045455,0.5,0.0954545],'Relief','default','SliderStep',[0.01,0.1],'String','Exponencial','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','mejorModelo','Callback','')
    case 4 then
        handles.mejorModelo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.0045455,0.5,0.0954545],'Relief','default','SliderStep',[0.01,0.1],'String','Potencia','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','mejorModelo','Callback','')
    end

endfunction

function plottear(iMatValues, iArrRegressions)
    xtitle ( "Regresiones con base en datos" , "Variable dependiente (X)" , "Variable independiente (Y)" );
    xgrid([1])
    
    // plottear los puntos del excel
    
    scatter(iMatValues(:, 1), iMatValues(:, 2), 36, "scilabred2","x")
    // plottear regresion lineal
    iTop = iMatValues(size(iMatValues, 1), 1) + 10
    xdata = linspace ( 1 , iTop , iTop * 2 );
    ydata = iArrRegressions(1).regFunc(xdata)
    plot(xdata, ydata, "r")
    // plotear regresion cuadratica
    ydata = iArrRegressions(2).regFunc(xdata)
    plot(xdata, ydata, "g")
    // plotear regresion exponencial
    ydata = iArrRegressions(3).regFunc(xdata)
    plot(xdata, ydata, "b")
    // plotear regresion potencia
    ydata = iArrRegressions(4).regFunc(xdata)
    plot(xdata, ydata, "k")
    legend(['Datos','Lineal','Cuadratico', "Exponencial", "Potencia"], [1])
endfunction

// This GUI file is generated by guibuilder version 4.2.1
//////////
f=figure('figure_position',[221,90],'figure_size',[640,480],'auto_resize','on','background',[33],'figure_name','Graphic window number %d','dockable','off','infobar_visible','off','toolbar_visible','off','menubar_visible','off','default_axes','on','visible','off');
//////////
handles.dummy = 0;
handles.examinarArchivo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.0048077,0.9045455,0.4903846,0.0886364],'Relief','default','SliderStep',[0.01,0.1],'String','Examinar Archivo de Pronostico','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','examinarArchivo','Callback','examinarArchivo_callback(handles)')
handles.Gráfica= newaxes();handles.Gráfica.margins = [ 0 0 0 0];handles.Gráfica.axes_bounds = [0.0352564,0.1,0.4647436,0.45];
params = [" " "y" "r^2" ];
towns = ["Lineal" "Cuadrático" "Exponencial" "Potencia"]';
pop  = ["valor1" "valor2" "valor3" "valor4"]';
//pop  = string([22.41 11.77 33.41 4.24]');
temp = ["valor1" "valor2" "valor3" "valor4"]';
table = [params; [ towns pop temp ]]
handles.tablaModelos=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.2022727,0.5,0.2],'Relief','default','SliderStep',[0.01,0.1],'String',table,'Style','table','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','tablaModelos','Callback','tablaModelos_callback(handles)')
handles.texto1=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.1,0.5,0.0931818],'Relief','default','SliderStep',[0.01,0.1],'String','El mejor modelo para el archivo es:','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','texto1','Callback','')
handles.mejorModelo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0,0.0045455,0.5,0.0954545],'Relief','default','SliderStep',[0.01,0.1],'String','Tipo de Modelo','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','mejorModelo','Callback','')
handles.texto2=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.5,0.9,0.2996795,0.1],'Relief','default','SliderStep',[0.01,0.1],'String','Usando cada modelo para el valor','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','texto2','Callback','')
handles.valorModelo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7996795,0.9,0.1971154,0.0977273],'Relief','default','SliderStep',[0.01,0.1],'String','Ingrese un valor...','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','valorModelo','Callback','')
handles.calcularModelo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.5977564,0.8022727,0.3028846,0.0977273],'Relief','default','SliderStep',[0.01,0.1],'String','Calcular con el valor','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','calcularModelo','Callback','calcularModelo_callback(handles)')

parameters = [" " "X"];
tipos = ["Lineal" "Cuadrático" "Exponencial" "Potencia"]';
pop  = string(["valor1" "valor2" "valor3" "valor4"]');
table1 = [parameters; [ tipos pop ]]
handles.tabladeValor=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.4983974,0.6,0.4983974,0.2022727],'Relief','default','SliderStep',[0.01,0.1],'String',table1,'Style','table','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','tabladeValor','Callback','tabladeValor_callback(handles)')
handles.texto3=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.5,0.5022727,0.4983974,0.0977273],'Relief','default','SliderStep',[0.01,0.1],'String','Los valores atipicos son:','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','texto3','Callback','')
handles.valorAtipicos=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.4983974,0.4,0.5,0.1],'Relief','default','SliderStep',[0.01,0.1],'String','Ati picos','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','valorAtipicos','Callback','')
handles.text4=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.5,0.3,0.4967949,0.1],'Relief','default','SliderStep',[0.01,0.1],'String','Ingresa lo que se pide para el archivo de excel','Style','text','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','text4','Callback','')
handles.inicioExcel=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.4983974,0.2,0.2019231,0.1],'Relief','default','SliderStep',[0.01,0.1],'String','Valor Inicio','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','inicioExcel','Callback','')
handles.finalExcel=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.4983974,0.1,0.2019231,0.1],'Relief','default','SliderStep',[0.01,0.1],'String','Valor Final','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','finalExcel','Callback','')
handles.intervalosExcel=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.4983974,0.0022727,0.2019231,0.0977273],'Relief','default','SliderStep',[0.01,0.1],'String','Diferencias entre intervalos:','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','intervalosExcel','Callback','')
handles.nombreArchivo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.6987179,0.2,0.2996795,0.1],'Relief','default','SliderStep',[0.01,0.1],'String','Ingrese Nombre del Archivo...','Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','nombreArchivo','Callback','')
handles.generarArchivo=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','center','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.7099359,0.0181818,0.2804487,0.1727273],'Relief','default','SliderStep',[0.01,0.1],'String','Generar el Archivo','Style','pushbutton','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','generarArchivo','Callback','generarArchivo_callback(handles)')


f.visible = "on";


//////////
// Callbacks are defined as below. Please do not delete the comments as it will be used in coming version
//////////


function examinarArchivo_callback(handles)
//Write your callback for  examinarArchivo  here
// lee los programas de excel
global iMatValues
iMatValues = GetExcelValues()
disp(iMatValues)
// estructuras de datos para guardar las regresiones
// regresion lineal
global iArrRegressions
global regLineal
regLineal = struct("regParams", GetRegLineal(iMatValues))
deff("y = funLineal(x)", "y = regLineal.regParams(1) + regLineal.regParams(2) * x")
regLineal.regFunc = funLineal
iArrRegressions(1) = regLineal
//regCuadratica
global regCuadratica 
regCuadratica = struct("regParams", GetRegCuadratica(iMatValues))
deff("y = funCuadratica(x)", "y = regCuadratica.regParams(1) + regCuadratica.regParams(2) * x + regCuadratica.regParams(3) * (x ^ 2)")
regCuadratica.regFunc = funCuadratica
iArrRegressions(2) = regCuadratica

// regExponencial
global regExponencial
regExponencial = struct("regParams", GetRegExponencial(iMatValues))
deff("y = funExponencial(x)", "y = regExponencial.regParams(1) * exp(regExponencial.regParams(2) * x)")
regExponencial.regFunc = funExponencial
iArrRegressions(3) = regExponencial

// reg Potencia
global regPotencia
regPotencia = struct("regParams", GetRegPotencia(iMatValues))
deff("y = funPotencia(x)", "y = regPotencia.regParams(1) * (x ^ (regPotencia.regParams(2)))")
regPotencia.regFunc = funPotencia
iArrRegressions(4) = regPotencia



// calcular r^2
iArrRegressions = GetR2(iMatValues, iArrRegressions)

plottear(iMatValues, iArrRegressions)

//Atipicos
for i = 1 : size(iMatValues, 1)
    dArrErrors(i) = iMatValues(i, 2) - iArrRegressions(3).regFunc(iMatValues(i, 1))
end
// se calcula la media de los errores
dErrorsMean = mean(dArrErrors)
dStdDevErrors = 0
// se calcula la desviacion estandar de los errores
for i = 1 : size(dArrErrors,1)
    dStdDevErrors = dStdDevErrors + ((dArrErrors(i) - dErrorsMean) ^ 2)
end
dStdDevErrors = (dStdDevErrors / size(dArrErrors,1)) ^ (1/2)
// se buscan los outliers
iContOutliers = 0
sAtipicos = ""
for i = 1 : size(dArrErrors, 1)
    // dT es el numero de desviaciones estandar a las que se encuentra el error del promedio
    dT = dArrErrors(i) / dStdDevErrors
    // se considera un Outlier si dT es mayor o igual a 2
    if (dT >= 2)
        iContOutliers = iContOutliers + 1
        // se agrega el outlier a una matriz donde se almacenan
        sAtipicos = sAtipicos + " (" + string(iMatValues(i, 1)) + ", " + string(iMatValues(i, 2)) +")"
        iArrOutliers(iContOutliers, 1) = iMatValues(i, 1)
        iArrOutliers(iContOutliers, 2) = iMatValues(i, 2) 
    end
end
handles.valorAtipicos=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.4983974,0.4,0.5,0.1],'Relief','default','SliderStep',[0.01,0.1],'String',sAtipicos,'Style','edit','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','valorAtipicos','Callback','')

endfunction


function tablaModelos_callback(handles)
//Write your callback for  tablaModelos  here

endfunction


function calcularModelo_callback(handles)
//Write your callback for  calcularModelo  here
global iMatValues
global iArrRegressions
global regLineal
global regCuadratica
global regExponencial
global regPotencia
global dNumMejor

valorRec=handles.valorModelo.string;
valorMod=strtod(valorRec)
regLin=string(iArrRegressions(1).regFunc(valorMod))
regCuad=string(iArrRegressions(2).regFunc(valorMod))
regExp=string(iArrRegressions(3).regFunc(valorMod))
regPot=string(iArrRegressions(4).regFunc(valorMod))
parameters = [" " "X"];
tipos = ["Lineal" "Cuadrático" "Exponencial" "Potencia"]';
pop  =[regLin regCuad regExp regPot]';
table1 = [parameters; [ tipos pop ]]
handles.tabladeValor=uicontrol(f,'unit','normalized','BackgroundColor',[-1,-1,-1],'Enable','on','FontAngle','normal','FontName','Tahoma','FontSize',[12],'FontUnits','points','FontWeight','normal','ForegroundColor',[-1,-1,-1],'HorizontalAlignment','left','ListboxTop',[],'Max',[1],'Min',[0],'Position',[0.4983974,0.6,0.4983974,0.2022727],'Relief','default','SliderStep',[0.01,0.1],'String',table1,'Style','table','Value',[0],'VerticalAlignment','middle','Visible','on','Tag','tabladeValor','Callback','tabladeValor_callback(handles)')

endfunction


function tabladeValor_callback(handles)
//Write your callback for  tabladeValor  here

endfunction


function generarArchivo_callback(handles)
global iArrRegressions
global regLineal
global regCuadratica
global regExponencial
global regPotencia
global dNumMejor
//Write your callback for  generarArchivo  here
// generar excel
nomArchivo=handles.nombreArchivo.string;
nomArchivo=nomArchivo+".csv"
//valorMod=strtod(valorRec)
//input(dar nombre excel)
inicioExcel=handles.inicioExcel.string;
finalExcel=handles.finalExcel.string;
intervalosExcel=handles.intervalosExcel.string;
iInicio = strtod(inicioExcel)
iFin = strtod(finalExcel)
iStep = strtod(intervalosExcel)
iIntervalos = round((iFin - iInicio + 1) / iStep)
xdata = linspace ( iInicio , iFin , iIntervalos);
ydata = iArrRegressions(dNumMejor).regFunc(xdata)
excelData(:,1) = xdata
excelData(:,2) = ydata
filename = fullfile(pwd(), nomArchivo)
csvWrite(excelData,filename)

endfunction
