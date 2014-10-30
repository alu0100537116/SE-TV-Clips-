;##############################################################
;###    S.E. PARA DIAGNOSTICAR PROBLEMAS DE TELEVISIONES    ###
;###    	  INTELIGENCIA ARTIFICIAL	             ###
;###           		LENGUAJE : CLIPS                    ###
;###		LORENZO ISMAEL MARTIN ALVAREZ               ###
;#############################################################

(deftemplate tv
	(slot enchufado(allowed-values si no))
	(slot encendido(allowed-values si no))
	(slot imagen_en_tv(allowed-values si no))

	; #### CASOS EN LOS QUE SI SE VE ALGO EN LA TV ####
	(slot cable_antena_tv_enchufado(allowed-values si no))
	(slot cable_antena_toma_enchufado(allowed-values si no))

	;#### CASOS EN LOS QUE NO SE VE NADA EN LA TV ####
	(slot euroconector_enchufado_tv(allowed-values si no))
	(slot euroconector_enchufado_tdt(allowed-values si no))
)


(deffacts valores_inicio
	(tv (enchufado si))
)



; ######## COMPROBAMOS SI LA TV ESTA ENCENDIDA #########



(defrule Regla1
	(initial-fact)
	=>
	(printout t "***********************************************************" crlf)
	(printout t "* Bienvenido al sistema de diagnostico de problemas en TV *" crlf)
	(printout t "***********************************************************" crlf)
	(printout t "" crlf)
	(printout t "-------------------------------------------------------------------------------------" crlf)
	(printout t "| Partiendo de que la televisión está enchufada, hagamos ahora un pequeño diagnostico|" crlf)
	(printout t "-------------------------------------------------------------------------------------" crlf)
	(printout t " - La televisión se encuentra encendida? [si/no]" crlf)
	(assert (encendido ( read )))
)



;######## COMPROBAMOS SI APARECE ALGO EN LA PANTALLA ######



(defrule Regla2
	(encendido si)
	=>
	(printout t "" crlf)
	(printout t "----------------------------------------------------" crlf)
	(printout t "| Hemos comprobado que la television esta encendida.|" crlf) 
	(printout t "----------------------------------------------------" crlf)
	(printout t " - ¿ Aparece alguna imagen en la pantalla ? si/no " crlf)
	(assert (imagen_en_tv(read)))
)




(defrule Regla3
	(encendido no)
	=>
	(printout t "" crlf)
	(printout t "------------------------" crlf)
	(printout t "| Encienda el televisor | " crlf)
	(printout t "------------------------" crlf)
	(printout t " - ¿ Se solucionó el problema? si/no " crlf)
	(bind ?opcion(read))
	(if (eq ?opcion si)then
		(printout t " El problema ha sido arreglado, disfrute de su TV " crlf)
		
	else
	(assert(encendido si))
	)
)


;########## SI APARECE IMAGEN ############



(defrule Regla4
	(encendido si)(imagen_en_tv si)
	=>
	(printout t "" crlf)
	(printout t "--------------------------------------------------------------------" crlf)
	(printout t "| Al aparecer imágen, podemos deducir que su TV esta en buen estado|" crlf)
	(printout t "| Sigamos con la siguiente comprobación:                           |"crlf)  
	(printout t "--------------------------------------------------------------------" crlf)
	(printout t " - ¿ Está bien conectado el cable de antena a la televisión/TDT ? si/no" crlf)
	(assert(cable_antena_tv_enchufado(read)))
)




(defrule Regla5
	(encendido si)(imagen_en_tv si)(cable_antena_tv_enchufado si)
	=>
	(printout t "" crlf)
	(printout t "----------------------------------------------------------------" crlf)
	(printout t "| El cable de antena se encuentra bien conectado en éste punto |" crlf)
	(printout t "----------------------------------------------------------------" crlf)
	(printout t " - ¿Se solucionó el problema? si/no  " crlf)
	(bind ?opcion(read))
	(if (eq ?opcion si) then
		(halt)
	else
	(printout t "---------------------------------------------------------------------" crlf)
	(printout t "| Pasamos a comprobar la otra punta del cable, en la toma de antena |" crlf)
	(printout t "---------------------------------------------------------------------" crlf)
	(printout t " - ¿ Se encuentra bien conectado ? si/no " crlf)
	(assert(cable_antena_toma_enchufado(read)))
	)
)




(defrule Regla6
	(encendido si)(imagen_en_tv si)(cable_antena_tv_enchufado no)
	=>
	(printout t "" crlf)
	(printout t "---------------------- -------" crlf)
	(printout t "| Enchufe el cable de antena |"crlf)
	(printout t "  ----------------------------" crlf)
	(printout t " - ¿ Se solucionó el problema? si/no " crlf)
	(bind ?opcion(read))
	(if (eq ?opcion si) then
		(printout t "----------------------------------------------------" crlf)
		(printout t "| El problema ha sido arreglado, disfrute de su TV |" crlf)
		(printout t "----------------------------------------------------" crlf)
		(halt)
	else 
		(assert(cable_antena_tv_enchufado si))
	)
)



(defrule Regla7
	(encendido si)(imagen_en_tv si)(cable_antena_tv_enchufado si)(cable_antena_toma_enchufado si)
	=>
	(printout t "" crlf)
	(printout t "-------------------------------------------------------------------------------------------------------" crlf)
	(printout t "| Hemos comprobado todo lo que está a su alcance,si el problema persiste consulte al servicio técnico |" crlf)
	(printout t "-------------------------------------------------------------------------------------------------------" crlf)
	(halt)
)




(defrule Regla8
	(encendido si)(imagen_en_tv si)(cable_antena_tv_enchufado si)(cable_antena_toma_enchufado no)
	=>
	(printout t "" crlf)
	(printout t "------------------------------------------------------------" crlf)
	(printout t "| Debe enchufar correctamente el cable a la toma de antena |" crlf)
	(printout t "------------------------------------------------------------" crlf)
	(printout t " - Una vez conectado, ¿persiste el problema?si/no " crlf)
	(bind ?opcion(read))
	(if (eq ?opcion si) then 
		(printout t "-------------------------------------------------------------------------------------------------------" crlf)
		(printout t "| Hemos comprobado todo lo que está a su alcance,si el problema persiste consulte al servicio técnico |" crlf)
		(printout t "-------------------------------------------------------------------------------------------------------" crlf)
		(halt)
	else
	      (printout t "----------------------------------------------------" crlf)
	      (printout t "| El problema ha sido arreglado, disfrute de su TV |" crlf)
	      (printout t "----------------------------------------------------" crlf)
		(halt)
	)
)



 ;########## SI NO APARECE IMAGEN ###########




(defrule regla9
	(encendido si)(imagen_en_tv no)
	=>
	(printout t "" crlf)
	(printout t "---------------------------------------------------" crlf)
	(printout t "| La pantalla se encuentra totalmente negra       |" crlf)
	(printout t "| Pasamos a comprobar el estado del euroconector  |" crlf)
	(printout t "---------------------------------------------------" crlf)
	(printout t "| Enchufe el euroconector correctamente a la tv |" crlf)
	(printout t "--------------------------------------------- ---" crlf)
	(printout t " - Se solucionó el problema ? si/no" crlf)
	(bind ?opcion(read))
	(if (eq ?opcion si) then
		(printout t "---------------------------------" crlf)
		(printout t "| El problema ha sido arreglado |" crlf)
		(printout t "---------------------------------" crlf)
		(halt)
	else
		(assert (euroconector_enchufado_tv si ))
	)
)



(defrule regla10
	(encendido si)(imagen_en_tv no)(euroconector_enchufado_tv si)
	=>
	(printout t "" crlf)
	(printout t "---------------------------------------------------" crlf)
	(printout t "| Teniendo el euroconector bien conectado a la TV |" crlf)
	(printout t "| Vamos a comprobar el estado en su otro extremo  |" crlf)
	(printout t "---------------------------------------------------------------" crlf)
	(printout t "| Enchufe correctamente el euroconector en el extremo del TDT |" crlf)
	(printout t "---------------------------------------------------------------" crlf)
	(printout t " - Se solucionó el problema? si/no " crlf)
	(bind ?opcion(read))
	(if (eq ?opcion si) then
		(printout t "----------------------------------------------------" crlf)
		(printout t "| El problema ha sido arreglado, disfrute de su TV |" crlf)
		(printout t "----------------------------------------------------" crlf)
		(halt)
	else	
		(printout t "-----------------------------------------------------------------------------" crlf)
		(printout t "| Ha comprobado todo lo que está a su alcance, consulte al servicio técnico |" crlf)
		(printout t "-----------------------------------------------------------------------------" crlf)
		(assert (euroconector_enchufado_tdt si))
		(halt)
	)
)
	

	
