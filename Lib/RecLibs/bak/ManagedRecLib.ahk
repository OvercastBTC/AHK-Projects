;---------------------------------------------------------------------------
;                           Autoexecute Section
;---------------------------------------------------------------------------
#Requires AutoHotkey v2+
#Include <Directives\__AE.v2>

;---------------------------------------------------------------------------
;                              CHANGELOG
;---------------------------------------------------------------------------
; Version 4 - 17 Sept 2023
; Updated recommendation code triggers to map to Horizon recommendation codes
; This will allow users to "search" for text by using the rec codes
;
; Version 3 - 28 August 2023
; Updated to AHK V2.
;
; Version 2 - 7 Mar 2023
; OS Titles now input in italics except for Horizon.
;
;
; Version 1.0 - Released 2/24/2023
; Modified to replace {Enter} with `n for line breaks as this is the proper method for line breaks.
; Also modified to break this script out into a sub-script to make maintenance easier for users, so they
; are not forced to update the starter script with all the personal information, which likely won't change
; as much as the sub-scripts.


;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
;           Common Risk Report Recommendations and Quick Parts
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------

;---------------- Weekly Valve Inspection ----------------------------------

:*:f-he-fpd-visual valve inspect title::Conduct weekly, documented, fire protection valve inspections.

:*:f-he-fpd-visual valve inspect rec FM::Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, FM Global offers the free, online, training course Inspecting Fire Protection Valves at https://training.fmglobal.com. Records of these inspections should be maintained on file.

:*:f-he-fpd-visual inspect rec AFM::Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, AFM offers the free, online, training course Inspecting Fire Protection Valves at https://training.fmglobal.com. Records of these inspections should be maintained on file.


;----------------- Weekly Fire Pump Inspection ----------------------------------

:*:f-he-fpd-weekly pump title::Conduct weekly documented fire protection pump tests via pressure drop.

:*:f-he-fpd-weekly pump rec::Automatic starting should be tested by simulating a drop in system pressure at the fire pump control panel. This is done by releasing pressure in the line leading to the controller's pressure sensor.`nAt each test, checks should be made of the operation of the priming devices, the temperature and tightness of the glands, the readings of the suction and discharge gauges, and the condition of the suction supply. Check actual start and stop pressures against pressure switch settings every time the fire pump unit is started.


;'---------------------- UTR Text -------------------------------------------

:*:utr-end text::Additional recommendations to reduce the exposures at this facility are contained within this report. These recommendations were not discussed in detail because of the focused nature of this visit. However, by implementing these recommendations the building will be less likely to incur a devastating loss that requires months to repair before normal operations can resume.


;-------------------------- Red Tag Recommendation ----------------------------------

:*:f-he-fpd-red tag title::Use the FM Global Red Tag Permit System.

:*:f-he-fpd-red tag rec FM::A formal, written policy on using the FM Global Red Tag Permit System to monitor all fire protection system valve closures should be developed. Sprinkler impairments should be submitted to FM Global online at https://redetag.fmglobal.com. To assist you with the implementation of the FM Global Red Tag Permit System, FM Global offers free, online, training at https://training.fmglobal.com.

:*:f-he-fpd-red tag rec AFM::A formal, written policy on using the FM Global Red Tag Permit System to monitor all fire protection system valve closures should be developed. Sprinkler impairments should be submitted to FM Global online at https://redetag.fmglobal.com. To assist you with the implementation of the FM Global Red Tag Permit System, AFM offers free, online, training at https://training.fmglobal.com.


;----------------------- Quarterly Waterflow Alarm Title ----------------------------

:*:f-he-fpd-quarterly waterflow title::Conduct quarterly, documented, waterflow alarm testing.

:*:f-he-fpd-quarterly waterflow rec::Waterflow alarms should be tested by opening the inspector’s test valves to flow water through the sprinkler system. For wet-pipe systems, use the inspector’s test connection at the extreme end of the system. For dry-pipe systems, use the hydraulic test connections at the dry-pipe valve. The waterflow alarm should activate within 90 seconds of the initial waterflow. Testing should be done only by well-trained personnel or by an inspection service to avoid unnecessary local disturbances and response by the public fire department. Following the test, the alarm monitoring company should be contacted to confirm that all test signals are received. Records of all testing should be retained for review.


;------------------ Monthly Physical Valve Inspection ---------------------------------

:*:f-he-fpd-physcial valve inspect title::Conduct monthly, documented, physical inspections of post-indicator valves.

:*:f-he-fpd-physical valve inspect rec::Monthly physical testing of post-indicator valves and wall post-indicator valves verifies that valves are open and that indicating mechanisms are properly aligned with the unit’s window. Records of these inspections should be maintained on file.`nPhysically inspecting a valve includes:`nUnlocking the valve.`nTurning the hand-wheel or wrench in the fully open position direction.`nTurning in the closed direction two or three turns to ensure operable condition.`nReturning the valve to the fully open position (feeling the spring in the shaft).`nBacking off approximately one-quarter turn to relieve the strain.`nRelocking the valve.


;-------------------------- Circuit Breaker Testing -------------------------------------

:*:e-he-elect-itm-breaker-title::Improve inspection, testing and maintenance practices for circuit breakers.

:*:e-he-elect-itm-breaker-rec::Manually exercise, inspect, service, lubricate, and test all critical/main low-voltage circuit breakers every three to five years in accordance with the manufactures guidelines' and/or industry standards as applicable. If there are no manufacturer guidelines or industry standards, use Tables 1a and 1b of FM Global Property Loss Prevention Data Sheet 5-19, Switchgear and Circuit Breakers, Section 2.1.4, Switchgear and Circuit Breakers Testing and Maintenance.`n`nTesting should focus on:`n-First circuit breaker downstream of the utility transformer;`n-Circuit breakers rated >1000-A;`n-Circuit breakers considered critical to production.


;----------------------------- Management of Change ---------------------------------------

:*:f-he-misc-plan review title::Utilize FM Global Plan Review services.

:*:f-he-misc-plan review rec::Get FM Global engineering involved during the initial planning stages (the earlier the better) for any new process or process changes, construction, roofing or roof repairs, changes in fire protection, installation of gas-fired equipment or occupancy changes.  Ideally, design documents should be reviewed early in project planning and no later than the ‘Schematics’ design phase, before the project scope and budget are developed. Early involvement by FM Global will allow alternative solutions or recommendations to be considered before budget, scope or schedule changes are required.


;---------------------------- Lock Sprinkler Valves ----------------------------------------

:*:f-he-fpd-lock valves title::Lock all fire sprinkler control valves in the wide-open position.

:*:f-he-fpd-lock valves rec::All sprinkler control valves larger than 1.5 in. should be locked in the fully open position with unbreakable locks and chains. Keys for the locks should be distributed to the personnel directly responsible for fire protection. During the risk evaluation the following valves were found unlocked.


;-------------------------- Install AS Sprinkler Protection --------------------------------

:*:f-ph-fpd-install sprinklers title ::Install automatic sprinkler protection in

:*:f-ph-misc-install sprinklers rec::Sprinkler protection should be installed in accordance with FM Global Property Loss Prevention Data Sheet 2-0, Installation Guidelines for Automatic Sprinklers, and FM Global Property Loss Prevention Data Sheet 2-8, Earthquake Protection for Water-Based Fire Protection Systems.`n`nBefore completing any such upgrade, FM Global should be contacted to review details of the proposed plans and coordinate the design with the contractor.


;------------------------------ Annual Infrared Inspection -----------------------------------

:*:e-he-elect-itm infrared title::Perform infrared thermographic surveys on all electrical equipment annually.

:*:e-he-elect-itm infrared rec::Infrared surveys of electrical equipment should be done only by a qualified contractor or employee. If surveys are to be completed in-house a detailed list of all equipment to be surveyed should be created so that the scope of the survey is well defined. Problems found during the survey and corrective action taken should be well documented for historic and trending purposes.


; ----------------------------------- Hot Work ----------------------------------------------

:*:f-he-misc-hot work title::Implement the use of the FM Global Hot Work Permit System.

:*:f-he-misc-hot work rec FM::The FM Global Hot Work Permit System should be used to monitor any cutting, welding, or other hot-work activity conducted outside areas specifically designated for hot-work operations. A formal, written policy statement should specify who has the authority to issue permits and should apply to hot work conducted by facilities personnel as well as outside contractors. Designated hot-work areas should also incorporate all appropriate precautions outlined in the Hot Work Permit System. To assist you with the implementation of the FM Global Hot Work Permit System, FM Global offers the free, online, training courses Managing Hot Work Using FM Global's Hot Work Permit System and Advancing Your Hot Work Skills at https://training.fmglobal.com.


:*:f-he-misc-hot work rec AFM::The FM Global Hot Work Permit System should be used to monitor any cutting, welding, or other hot-work activity conducted outside areas specifically designated for hot-work operations. A formal, written policy statement should specify who has the authority to issue permits and should apply to hot work conducted by facilities personnel as well as outside contractors. Designated hot-work areas should also incorporate all appropriate precautions outlined in the Hot Work Permit System. To assist you with the implementation of the FM Global Hot Work Permit System, AFM offers the free, online, training courses Managing Hot Work Using FM Global's Hot Work Permit System and Advancing Your Hot Work Skills at https://training.fmglobal.com.


;---------------------- Emergency Response Plan ------------------------------------------

:*:f-he-misc-ERP title::Improve the existing emergency response plan (ERP)

:*:f-he-misc-ERP rec::The ERP should include the following positions:`nPerson-in-Charge - This person directs actions of personnel, is responsible for keeping the ERP roster current and ensuring personnel are trained.`nNotifier - The notifier is designated to call the fire department.`nSprinkler Valve Operator - In the event of a fire, this person goes to the valve controlling the fire area and ensures it is open.`nUtilities Operator - This person assists the fire department as needed to shut down utilities and hazardous processes.`nFire Pump Operator - The fire pump operator is designated to respond to the fire pump and ensure it is operating.`n`nMembers of the emergency response team should be provided with quarterly refresher training.