ear; additional 13.8 kV swgr direct tie. Stepped down to 4160 and 2400 as needed

[- Notes -]
- Arc flash event 2/2019 in ER20.
- Main xfmr's oil was filtered in 2022 - tested-filtered-retested. DGA retest noted - No historyClass RecLibs {

	RQA := Map(
		'fair-good to good', '
		(
			B&M risk is fair-good to good.

			^b^uElectrical Integrity:^b^u
			- Electrical inspection, testing, and maintenance (ITM) has not been performed in a long time, if every; the site expects it hasn't been done since installation (1990s, early 2000s)
			- The as-built electrical single-line diagrams are considerably out of date.
			- The site did not have, nor could find, the 2017 arc-flash hazard analysis. There are action items that still need to be completed.

			^b^uMechanical Integrity:^b^u
			- Meets or exceeds original equipment manufacturer (OEM) and/or FM Globals standards

			^b^uManagement of Change (MOC):^b^u
			There is a fair-good MOC program in place; however, the key deficiency is a lack of a cross-functional, or interdepartmental, review team. The Facilities Maintenance is handed over a "finished product" without any turnover, from Facilities Engineering.
			The following could have been completed/performed during the required outage on the low voltage (LV) switchgear:
			- The three (to five) year offline electrical inspection, testing, and maintenance (ITM)
			- The electrical system studies
			- Updating the as-built electrical single-line diagrams

			^b^uResiliency:^b^u
			Most of the systems at this facility are N+1 throughout, and critical electronic business systems are mirrored in Las Vegas, Nevada, and Austin, Texas data centers.
			- The data center for Mega Jackpot is backed up to the Las Vegas, Nevada data center

			Management, operations, and maintenance personnel, readily received all industry best practices, recommendations, and suggestions. Once an interdepartmental communication bridge is built, they will be excellent partners in resiliency.
		)'
	)

	static understanding_the_risk := [
		
		"electrical 1° exposure - 1", "
		(
		From the Boiler and Machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure.
		
		A robust asset integrity program coupled with thorough maintenance, and effective management of change, are essential to ensuring resilience, and reliable production.
		
		Management, operations, and maintenance personnel have been working diligently to improve the maintenance programs and practices. Any gaps in maintenance routines are identified and reviewed for implementation. Site management and maintenance personnel should be commended for their ongoing efforts in this area.
		
		In addition to the formal recommendations made, additional comments have been provided that also represent good loss prevention advice and should be completed.
		
		As the world's largest soda ash mine and manufacturing plant, this facility is a very valuable asset for Genesis Alkali Holdings.
		
		From the fire and natural hazards (F&NH) perspective, ignitable liquids at the ELDM plant remain one of the largest exposures here. Their ability to spread over a large area and their high heat of combustion make them difficult to extinguish, which result in large fires with considerable smoke and water damage. Improving the storage of ignitable liquids at the ELDM plant, as outlined in this report, would help reduce the likelihood of a severe ignitable liquid fire.
		
		From the boiler and machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure - specifically the medium voltage switchgear batteries. The battery testing recommendation was completed and the issues were identified and corrected. The next step is to improve the asset management by monitoring and controlling the temperature to as close to 77°F as practical, and have a remote alarm to a constantly attended location. 
		
		A robust asset integrity strategy coupled with thorough documentation, is necessary for trending, predicting, outage planning, and/or supporting an effective asset management program.
		
		Management and maintenance personnel have been working diligently to improve the asset integrity programs, and should be commended for their ongoing efforts in this area. Any gaps in maintenance routines are identified and reviewed for implementation.
		
		In addition to the formal recommendations made, additional comments have been provided that also represent industry best practices, and should be completed.
		)",
		"electrical 1° exposure - 2", "
		(
			International Game Technology (IGT) continues to be a global leader in gaming machines, specializing in design, manufacturing and marketing of electronic gaming equipment and network systems. This location at Prototype Drive is its primary manufacturing location and also houses servers that monitor IGT equipment at various locations, as well as the Mega Jackpot games. As the heart of IGT, all business operations must be sustained and maintained at its highest level.

			FM Global believes that most losses are preventable. By identifying the inherent hazard of this type of occupancy and presenting engineering-driven, loss-prevention solutions, FM Global offers its best advice to protect this site's property and business, along with those of its customers.

			From the Boiler and Machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure.

			A robust asset integrity program coupled with thorough maintenance, and effective management of change, are essential to ensuring resilience, and reliable production; and by addressing critical recommendations outlined in the last coordination power system study. Ensuring support systems remain reliable is critical to supporting the value and profitability this facility represents.

			Management, operations, and maintenance personnel have been working diligently to improve the maintenance programs and practices. Any gaps in maintenance routines are identified and reviewed for implementation. Site management and maintenance personnel should be commended for their ongoing efforts in this area.

			In addition to the formal recommendations made, additional comments have been provided that also represent good loss prevention advice and should be completed.

		)"
	]
	static map_understanding_the_risk := Map(
		
		"electrical 1° exposure - itm", "
		(
		From the Boiler and Machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure.
		
		A robust asset integrity program coupled with thorough maintenance, and effective management of change, are essential to ensuring resilience, and reliable production.
		
		Management, operations, and maintenance personnel have been working diligently to improve the maintenance programs and practices. Any gaps in maintenance routines are identified and reviewed for implementation. Site management and maintenance personnel should be commended for their ongoing efforts in this area.
		
		In addition to the formal recommendations made, additional comments have been provided that also represent good loss prevention advice and should be completed.
		
		As the world's largest soda ash mine and manufacturing plant, this facility is a very valuable asset for Genesis Alkali Holdings.
		
		From the fire and natural hazards (F&NH) perspective, ignitable liquids at the ELDM plant remain one of the largest exposures here. Their ability to spread over a large area and their high heat of combustion make them difficult to extinguish, which result in large fires with considerable smoke and water damage. Improving the storage of ignitable liquids at the ELDM plant, as outlined in this report, would help reduce the likelihood of a severe ignitable liquid fire.
		
		From the boiler and machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure - specifically the medium voltage switchgear batteries. The battery testing recommendation was completed and the issues were identified and corrected. The next step is to improve the asset management by monitoring and controlling the temperature to as close to 77°F as practical, and have a remote alarm to a constantly attended location. 
		
		A robust asset integrity strategy coupled with thorough documentation, is necessary for trending, predicting, outage planning, and/or supporting an effective asset management program.
		
		Management and maintenance personnel have been working diligently to improve the asset integrity programs, and should be commended for their ongoing efforts in this area. Any gaps in maintenance routines are identified and reviewed for implementation.
		
		In addition to the formal recommendations made, additional comments have been provided that also represent industry best practices, and should be completed.
		)",
		
	)

	weekly_valve_inspection := Map(
		':*:wvit::', 'Conduct weekly, documented, fire protection valve inspections.',
		':*:wvirfm::', 'Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, FM Global offers the free, online, training course Inspecting Fire Protection Valves at https://fmglobaltraining.skillport.com. Records of these inspections should be maintained on file.',
		':*:wvirafm::', 'Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, AFM offers the free, online, training course Inspecting Fire Protection Valves at https://affiliatedfmtraining.skillport.com. Records of these inspections should be maintained on file.',

	)
	weekly_fire_pump_inspection := Map(
		':*:weeklypumpt::', 'Conduct weekly documented fire protection pump tests via pressure drop.',
		':*:weeklypumpr::', "Automatic starting should be tested by simulating a drop in system pressure at the fire pump control panel. This is done by releasing pressure in the line leading to the controller's pressure sensor.{Enter}At each test, checks should be made of the operation of the priming devices, the temperature and tightness of the glands, the readings of the suction and discharge gauges, and the condition of the suction supply. Check actual start and stop pressures against pressure switch settings every time the fire pump unit is started."
	)
	Class HumanElement {
		static electrical := Map(
			'design', '
			(
				[-Design-]
				Single feed, to 13.8 kV switchgear; additional 13.8 kV swgr direct tie. Stepped down to 4160 and 2400 as needed
			)',
		
			'notes', '
			(
				[-Notes-]
				- Arc flash event 2/2019 in ER20.
				- Main xfmr's oil was filtered in 2022 - tested-filtered-retested. DGA retest noted - No history - due to filtering.
				- Arc-flash: 2019
				- Swgr Replcmnt Proj: Started 2022
			)',
		
			'sNote', '
			(
				[-Special Note-] (AJB - 04/2023)
				The site was unable to validate the following statement included in a previous RR:
				The K2 DC drive was found to have an undersized breaker and was reportedly followed-up on by the plant immediately.
			)',
		
			'xfmrs5+', '
			(
				[-Xfmrs (>5MVA)-]
				[Online]
				Vis: D
				IR: A
				DGA/O: A
				[Offline]
				Testing: 3 yr
				Last 2022
				Prior: No
				[5-4:Tbl 2]
				Last:
				Prev:
			)',

			'xfmrs5-','
			(   
				[-Xfmrs (<5MVA)-] (who owns)
				[Online]
				Vis: D
				IR: A
				DGA/O: A
				[Offline]
 - due to filtering.
 - Arc-flas: 2019
 - Swgr Replcmnt Proj: Started 2022

 [- Special Note -] (AJB - 04/2023)
 The site was unable to validate the following statement included in a previous RR:
 - The K2 DC drive was found to have an undersized breaker and was reportedly followed-up on by the plant immediately.

 [- Xfmrs (>5MVA) -]
 Own (U | C): U
 [Online]
 Vis: D
 IR: A
 DGA/O: A
 [Offline]
 Testing: 3 yr
 Last 2022
 Prior: No
 [5-4:Tbl 2]
 Last:
 Prev:

 [- Xfmrs (<5MVA) -]
 Own (U | C): U
 [Online]
 Vis: D
 IR: A
 DGA/O: A
 [Offline]
 Testing: 3 yr
 [5-20: Table 6]
 Last: 2022
 Prev: No History

 [- MV Swgr -]
 [Online]
 Vis: W
 IR: A
 PD: No
 C/C/D/T: No
 [Offline]
 C/I/E: A
 [Bkr Testing]
 Tbl 1a: 3yr
 Tbl 1b: 3yr
 Relay Testing: 3yr
 [Tbl 1a]
 Last: 2022
 Prev: 2019

 [- Batts -]
 Date Code: 5/2021
 C/D/T: No
 Cool: No
 [Online]
 IR: No
 Vis: M
 W/T: M
 Capacitance (Internal Ohmic): No
 [O[- LV Swgr -][Online]Vis: WIR: AC/D/T: YClean: Ok[Offline]C/I/E:A[5-20:Tl 1]Lat				

				Testing: 3 yr
				[5-20: Table 6]
				Last: 2022
				Prev: No History
			)',
			
			'mvswgr', '
			(
				[-MV Swgr-]
				[Online]
				Vis: W
				IR: A
				PD: No
				C/C/D/T: No
				[Offline]
				C/I/E: A
				[Bkr Testing]
				Tbl 1a: 3yr
				Tbl 1b: 3yr
				Relay Testing: 3yr
				[Tbl 1a]
				Last: 2022
				Prev: 2019
			)',
		
			'batts', '
			(
				[-Batts-]
				Date Code: 5/2021
				C/D/T: No
				Cool: No
				[Online]
				IR: No
				Vis: M
				W/T: M
				Capacitance (Internal Ohmic): No
				[Offline]
				Capacity: No
				[Rmt Mon]
				Temp: No
				Low Voltage: No
			)',

			'lvswgr', '
			(
				[-LV Swgr-]
				[Online]
				Vis: W
				IR: A
				C/D/T: Y
				Clean: Ok
				[Offline]
				C/I/E: A
				[5-20:Tbl 1]
				Last: 2022
				Prev: 2019
			)',
		
			'edg', '
			(
				[-EDG-] (quarry portable crusher)
				ITM: S/A, A
				No Loads: W
				Load Xfr: M
				Load Bank: A
				Batts: rplc. 5yrs
			)',
		)
	}
	; --------------------------------------------------------------------------------
	Class LV_Electrical {
		; --------------------------------------------------------------------------------
		electrical_studies := Map(

			'title', 'Update the five year electrical system studies.',
			'reccomendation','
			(
				Perform the fault current and protection coordination studies per FM Global Property Loss Prevention Data Sheet 5-20, ^iElectrical Testing^i.

				As an alternative, an arc-flash hazard analysis (or arc flash study) meets the intent of the recommendation. Please see the technical detail section for additional information.

				^iNote: There is no impact to production as these studies are performed while online.^i
			)',

			'hazard', 'Circuit breakers are critical safety devices. Failure of a circuit breaker to trip will allow the electrical fault to persist and damage downstream equipment, jeopardize personnel safety, and cause electrical system instability. Electrical system studies will ensure the electrical system is appropriately aligned to interrupt the fault.',

			'tech detail', '
			(
				^b^uStudies and Alternative Names:^b^u
				- Short circuit/fault current
				- protection coordination/selective tripping
				- arc-flash hazard analysis/arc-flash study

				^b^uPrimary Studies:^b^u
				^bArc-Flash:^b
				- The final product is based on information obtained from the fault current and coordination studies.
				- The final product also generates a system diagram (single-line) similar to the as-built electrical single-line diagram. It is common to use the system diagram to review and update the as-built single line diagram, and is usually a service provided by the performing vendor.
				^bSelective Tripping:^b
				- The selective tripping, or coordination study, determines the extent of over-current protective device coordination within an electrical system.
				- The intent is when a fault occurs anywhere in the system, the current interruption device closest to the fault will actuate and isolate the fault.
				^bFault Current:^b
				- The fault current study determines the ability of each component within an electrical system to withstand and/or interrupt the system and fault currents.

				^bGeneral Guidance:^b
				- An electrical vendor is the best resource for the overall accomplishment of this recommendation. Should their guidance differ from this recommendation, please reach out to FM Global prior to implementation.
				- The standard industry periodicity is once every five years. However, an effective management of change (MOC) program can capture any changes made, and thereby identify any needed modifications required, to the protection device(s) of the electrical infrastructure.

				^b^uAdditional Secondary Study:^b^u
				^bLoad Balancing:^b
				- Load-balancing studies ensure loads are balanced across all three phases. This prevents damage, or additional wear, on particularly susceptible components such as motors and electronics (PLCs/circuit cards).
				- Another factor to consider: unbalanced loads can affect the site power factor and increase electricity costs.
				- This study is normally performed during initial construction and commissioning of the electrical infrastructure; as needed, it is also performed when changes occur.
				^iNote: This study is an industry best practice, and not required to complete this recommendation, but is highly recommended, and can be completed at the same time.^i
			)'
		)
		; --------------------------------------------------------------------------------
		MOC := Map(

		'title', 'Improve the existing management of change (MOC) program.',
		'reccomendation', '
		(
			Expand the existing management of change (MOC) process per FM Global Property Loss Prevention Data Sheets 9-0, ^iAsset Integrity^i; 7-43, ^iProcess Safety^i; and 10-8, ^iOperators^i.

			^bIdentified Deficiencies:^b
			- The current informal MOC process depends on the existing expertise and experience of site management and personnel
			- No formalized/standardized process for a cross functional team (e.g., cross departmental) review exists
			- No formal closeout policy and procedure(s) for obtaining closeout inspections and documentation prior to project completion
			^iNote: A formalized process establishing the scope of work does exist, but does not include a formalized closeout process/procedure/checklist.^i
		)',

		'hazard', 'MOC is a structured approach to managing the hazards inherent in processes by applying good design, engineering, and operating practices. A full evaluation for any changes in production, utility and support systems as well as procedural changes, hazard evaluations, etc., associated with those changes, should be evaluated as early as the design stage. Operational hazards, if not properly managed, can result in significant business interruption in the form of property damage and loss of production.',

		'technical', '
		(
			^bKey Deficiency:^b
			A recent project required the low voltage switchgear to be de-energized for circuit installation/re-configuration. During this time, with an effective management of change (MOC) process, the need to perform inspection, testing, and maintenance (ITM) on the low voltage switchgear would have been accomplished.

			^bGeneral Guidance:^b
			An effective MOC program and policy is a living document, subject to many changes throughout its lifetime. It is also highly complex and versatile, and extensively intertwined throughout all aspects of business operations. As business operations change, it is essential that these changes be carefully reviewed, and any potential impacts/hazards are identified.

			^iNote 1: You know your business, and how the MOC process can be best applied to your unique set of circumstances. Customize and personalize the process and language to site specific conditions.^i

			^b^iThe following sections include general/generic examples, and are to be used for reference only.^b^i

			^bMOC Evaluation Triggers:^b
			- Servicing (maintenance) changes/increases
			- Equipment installations/upgrades
			- Increases or changes to production demands

			^bMOC Example Questions:^b
			- How are equipment/process changes going to affect equipment operating procedures ?
			- What impact does/should this change have on inspection, testing, and maintenance (ITM) schedules (e.g., increases, decreases in periodicity, or change of scope)?
			- How does equipment/process changes impact current training requirements?
			- Do the electrical single line diagrams require updating (locally/site wide)?
			- Do the electrical system studies require updating (locally/site wide)?
			- Have all departments evaluated this (these) change(s) for impact?
			- Is redundancy required for the process/equipment?

			^bAdditional Guidance:^b
			- An extensive document or process, customized to local conditions, should include a checklist/sign-off sheet of questions, and a formal review and approval process.
			- The process should also include interdepartmental (cross-functional team) reviews (e.g., Facilities, environmental health and safety [EHS], Critical Infrastructure, IT, etc.).
			- The process should track the entire change, from initial request, to final sign-off prior to handover to the site.

			Please see the data sheets for additional guidance.
		)'
		)
		; --------------------------------------------------------------------------------
		single_lines := Map(

		'rec code','
		(
			Equipment / Human Element / Electrical / 
			
			LE=0 - Improve Documentation/Records-Elect Asset Integrity Progr and Inspect/Test/Maint
		)',
		
		'title', 'Update the as-built electrical single-line diagrams.',

		'reccomendation', 'Update the as-built electrical single-line diagrams to reflect the latest electrical system studies, or arc-flash hazard analysis, provide it to FM Global, and post the applicable single-line diagram in the associated electrical rooms',

		'hazard','Up to date electrical single-lines, including the information from the electrical system studies, will ensure the electrical system is appropriately designed, aligned to interrupt faults.',

		'technical', '
		(
			^bIdentified Deficiency:^b
			- The as-built electrical single-line diagrams inconsistently updated, or severely outdated. Since then, many important changes have occurred at the site, and to its electrical infrastructure. This was confirmed by site management.

			^bUpdate Guidance:^b
			- It is highly recommended to have/keep this living document up to date; this should be included in the management of change (MOC) program for evaluation.
			- Once established, this vital information will be used for any proposed changes or additions under the MOC program.
			- Unless equipment is being replaced with "like-kind", or no changes have occurred, the electrical as-built single-line and electrical system studies need to be updated every five years.
			- This should be under a document control and review system, including the drawings posted in the electrical rooms. This will ensure all parties involved will have the latest information to make informed decisions.

			For additional information, please engage a specialized vendor, and the applicable industry standards (e.g., NFPA 70-E, IEEE/NETA).
			
			^bAlternative:^b
			In combination with an arc-flash hazard analysis, the information and documentation can be provided to the drafting vendor of choice. This will significantly lower the cost, and streamline the process.
			^iNote: An arc-flash hazard analysis requires the necessary electrical system studies be performed as part of the process; it also provides a version (non as-built version) of a single-line diagram.^i
		)'
		)
		; --------------------------------------------------------------------------------
		IR_LV_Swgr := Map(
			'rec code','
		(
			[To be filled out]
		)',
		
		'title', 'Implement an infrared thermographic (IR) survey program for the low voltage (LV) switchgear.',

		'reccomendation', 'Expand the existing infrared thermographic (IR) program per FM Global Property Loss Prevention Data Sheet 5-20, ^iElectrical Testing^i.',

		'hazard','Malfunctioning electrical equipment can generate excessive heat due to corrosion, dirt, loose connections or overload. Infrared testing can identify faults before incidents or failures occur, avoiding costly, unscheduled downtime and business interruption.',

		'technical', '
		(
			
		)'
		)
	}
	; --------------------------------------------------------------------------------
}

;ListHotkeys
;#NoTrayIcon
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
;           Common Risk Report Recommendations and Quick Parts
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------

;---------------- Weekly Valve Inspection ----------------------------------

:*:wvit::Conduct weekly, documented, fire protection valve inspections.

:*:wvirfm::Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, FM Global offers the free, online, training course Inspecting Fire Protection Valves at https://fmglobaltraining.skillport.com. Records of these inspections should be maintained on file.

:*:wvirafm::Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, AFM offers the free, online, training course Inspecting Fire Protection Valves at https://affiliatedfmtraining.skillport.com. Records of these inspections should be maintained on file.


;----------------- Weekly Fire Pump Inspection ----------------------------------

:*:weeklypumpt::Conduct weekly documented fire protection pump tests via pressure drop.

:*:weeklypumpr::Automatic starting should be tested by simulating a drop in system pressure at the fire pump control panel. This is done by releasing pressure in the line leading to the controller's pressure sensor.{Enter}At each test, checks should be made of the operation of the priming devices, the temperature and tightness of the glands, the readings of the suction and discharge gauges, and the condition of the suction supply. Check actual start and stop pressures against pressure switch settings every time the fire pump unit is started.'


;---------------------- UTR Text -------------------------------------------

;:*:uthi::Additional recommendations to reduce the exposures at this facility are contained within this report. These recommendations were not discussed in detail because of the focused nature of this visit. However, by implementing these recommendations the building will be less likely to incur a devastating loss that requires months to repair before normal operations can resume.

:*:utrelecf::
{ 
A_Clipboard:=""
Sleep(100)
A_Clipboard :="
(
From the Boiler and Machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure.

A robust asset integrity program coupled with thorough maintenance, and effective management of change, are essential to ensuring resilience, and reliable production.

Management, operations, and maintenance personnel have been working diligently to improve the maintenance programs and practices. Any gaps in maintenance routines are identified and reviewed for implementation. Site management and maintenance personnel should be commended for their ongoing efforts in this area.

In addition to the formal recommendations made, additional comments have been provided that also represent good loss prevention advice and should be completed.

As the world's largest soda ash mine and manufacturing plant, this facility is a very valuable asset for Genesis Alkali Holdings.

From the fire and natural hazards (F&NH) perspective, ignitable liquids at the ELDM plant remain one of the largest exposures here. Their ability to spread over a large area and their high heat of combustion make them difficult to extinguish, which result in large fires with considerable smoke and water damage. Improving the storage of ignitable liquids at the ELDM plant, as outlined in this report, would help reduce the likelihood of a severe ignitable liquid fire.

From the boiler and machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure - specifically the medium voltage switchgear batteries. The battery testing recommendation was completed and the issues were identified and corrected. The next step is to improve the asset management by monitoring and controlling the temperature to as close to 77°F as practical, and have a remote alarm to a constantly attended location. 

A robust asset integrity strategy coupled with thorough documentation, is necessary for trending, predicting, outage planning, and/or supporting an effective asset management program.

Management and maintenance personnel have been working diligently to improve the asset integrity programs, and should be commended for their ongoing efforts in this area. Any gaps in maintenance routines are identified and reviewed for implementation.

In addition to the formal recommendations made, additional comments have been provided that also represent industry best practices, and should be completed.
)"
Send("^v")

} 
:*:utrmechf::
{ 
A_Clipboard:=""
Sleep(100)
A_Clipboard :="
(
This facility is important to Graymont Western US Inc. because there is no other lime production in this region. Over the years, the facility has developed strong relationships with its clients. Future production rates may rise due to possible increases in customer demand. The facility can continue to provide for its customers provided there are no major interruptions.`n`n
)"
Send("^v")
Sleep(100)
Send('^b')
Sleep(100)
Send('^u')
Sleep(300)
Send('Boiler and Machinery (B&M):')
Sleep(300)
Send('^b')
Sleep(100)
Send('^u')
Sleep(100)
A_Clipboard := ""
Sleep(100)
Send('`n')
A_Clipboard := "
(
From B&M perspective, the primary exposure is failure of mechanical rotating equipment. The gears that turn these large kilns and mills can take up to 18 months to receive once ordered. Current production rates preclude the possibility of long-term makeup by the other production equipment. The lack of nondestructive examination/testing (NDE/T) program, and/or spare ring gear segments,  is a cause for concern and brings this risk to the forefront. A formal, documented, equipment contingency plan (ECP) exists; however, upon further review, the vendor (Metso) was unable to find the drawings/specifications for the bull gears. This is critical information that can cause significant delay, should be maintained on-file, and included in the ECP.

The secondary minor exposure is failure of the electrical infrastructure. Due to a FM Global standards change based on loss history and industry changes, annual partial discharge (PD) online surveys on 4 kV switchgear/circuit breakers are now being recommended versus previous "best practice" guidance. 

A robust asset integrity strategy, coupled with thorough documentation, is necessary for trending, predicting, outage planning, and/or supporting an effective inspection, testing, and maintenance program.

Management, operations, and maintenance personnel have been working diligently to improve the maintenance programs and practices. Any gaps in maintenance routines are identified and reviewed for implementation; they should be commended for their ongoing efforts in this area.

In addition to the formal recommendations made, additional comments have been provided that also represent industry best practices, and should be completed.
)"
Send("^v")
} 
;---------------------- End of UTR Text -------------------------------------------

;---------------------- ICS Comment -------------------------------------------

;:*:uthi::Additional recommendations to reduce the exposures at this facility are contained within this report. These recommendations were not discussed in detail because of the focused nature of this visit. However, by implementing these recommendations the building will be less likely to incur a devastating loss that requires months to repair before normal operations can resume.
; Return
;-------------------------- Red Tag Recommendation ----------------------------------

:*:rtpst::Use of the FM Global Red Tag Permit System.

:*:rtpsrfm::A formal, written policy on using of the FM Global Red Tag Permit System to monitor all fire protection system valve closures should be developed. Sprinkler impairments should be submitted to FM Globalâ€™s San Francisco office via phone (888 247 9062), fax (800 736 5564) or online at https://redetag.fmglobal.com. To assist you with the implementation of the FM Global Red Tag Permit System, FM Global offers free, online, training at https://fmglobaltraining.skillport.com.

:*:rtpsrafm::A formal, written policy on using the FM Global Red Tag Permit System to monitor all fire protection system valve closures should be developed. Sprinkler impairments should be submitted to FM Globalâ€™s San Francisco office via phone (888 247 9062), fax (800 736 5564) or online at https://redetag.fmglobal.com. To assist you with the implementation of the FM Global Red Tag Permit System, AFM offers free, online, training at https://affiliatedfmtraining.skillport.com.


;----------------------- Quarterly Waterflow Alarm Title ----------------------------

:*:qwft::Conduct quarterly, documented, waterflow alarm testing.

:*:qwfr::Waterflow alarms should be tested by opening the inspectors test valves to flow water through the sprinkler system. For wet-pipe systems, use the inspectorâ€™s test connection at the extreme end of the system. For dry-pipe systems, use the hydraulic test connections at the dry-pipe valve. The waterflow alarm should activate within 90 seconds of the initial waterflow. Testing should be done only by well-trained personnel or by an inspection service to avoid unnecessary local disturbances and response by the public fire department. Following the test, the alarm monitoring company should be contacted to confirm that all test signals are received. Records of all testing should be retained for review.


;------------------ Monthly Physical Valve Inspection ---------------------------------

:*:mvit::Conduct monthly, documented, physical inspections of post-indicator valves.

:*:mvir::Monthly physical testing of post-indicator valves and wall post-indicator valves verifies that valves are open and that indicating mechanisms are properly aligned with the unitâ€™s window. Records of these inspections should be maintained on file.{Enter}Physically inspecting a valve includes:{Enter}Unlocking the valve.{Enter}Turning the hand-wheel or wrench in the fully open position direction.{Enter}Turning in the closed direction two or three turns to ensure operable condition.{Enter}Returning the valve to the full open position (feeling the spring in the shaft).{Enter}Backing off approximately one-quarter turn to relieve the strain.{Enter}Relocking the valve.

;-------------------------- Low Voltage Recs -------------------------------------

:*:rlvf::Improve inspection, testing and maintenance practices for circuit breakers.

;----------------------------- Management of Change ---------------------------------------

:*:mchanget::Utilize FM Global Plan Review services.

:*:mchanger::Get FM Global engineering involved during the initial planning stages (the earlier the better) for any new process or process changes, construction, roofing or roof repairs, changes in fire protection, installation of gas-fired equipment or occupancy changes.  Ideally, design documents should be reviewed early in project planning and no later than the â€˜Schematicsâ€™ design phase, before the project scope and budget are developed. Early involvement by FM Global will allow alternative solutions or recommendations to be considered before budget, scope or schedule changes are required.

;---------------------------- Lock Sprinkler Valves ----------------------------------------

:*:lvt::Lock all fire sprinkler control valves in the wide-open position.

:*:lvr::All sprinkler control valves larger than 1.5 in. should be locked in the fully open position with unbreakable locks and chains. Keys for the locks should be distributed to the personnel directly responsible for fire protection. During the risk evaluation the following valves were found unlocked.

;-------------------------- Install AS Sprinkler Protection --------------------------------

:*:installast::Install automatic sprinkler protection in

:*:installasr::Sprinkler protection should be installed in accordance with FM Global Property Loss Prevention Data Sheet 2-0, Installation Guidelines for Automatic Sprinklers and FM Global Property Loss Prevention Data Sheet 2-8, Earthquake Protection for Water-Based Fire Protection Systems.{Enter}Before completing any such upgrade, FM Global should be contacted to review details of the proposed plans and coordinate the design with the contractor.

;------------------------------ Annual Infrared Inspection -----------------------------------

:*:irt::Perform infrared thermographic surveys on all electrical equipment annually.

:*:irr::Infrared surveys of electrical equipment should be done only by a qualified contractor or employee. If surveys are to be completed in-house a detailed list of all equipment to be surveyed should be created so that the scope of the survey is well defined. Problems found during the survey and corrective action taken should be well documented for historic and trending purposes.

; ----------------------------------- Hot Work ----------------------------------------------

:*:hwpst::Implement the use of the FM Global Hot Work Permit System.

:*:hwpsrfm::The FM Global Hot Work Permit System should be used to monitor any cutting, welding, or other hot-work activity conducted outside areas specifically designated for hot-work operations. A formal, written policy statement should specify who has the authority to issue permits and should apply to hot work conducted by facilities personnel as well as outside contractors. Designated hot-work areas should also incorporate all appropriate precautions outlined in the Hot Work Permit System. To assist you with the implementation of the FM Global Hot Work Permit System, FM Global offers the free, online, training courses Managing Hot Work Using FM Global's Hot Work Permit System and Advancing Your Hot Work Skills at https://fmglobaltraining.skillport.com.

:*:hwpsrfm::The FM Global Hot Work Permit System should be used to monitor any cutting, welding, or other hot-work activity conducted outside areas specifically designated for hot-work operations. A formal, written policy statement should specify who has the authority to issue permits and should apply to hot work conducted by facilities personnel as well as outside contractors. Designated hot-work areas should also incorporate all appropriate precautions outlined in the Hot Work Permit System. To assist you with the implementation of the FM Global Hot Work Permit System, AFM offers the free, online, training courses Managing Hot Work Using FM Global's Hot Work Permit System and Advancing Your Hot Work Skills at https://affiliatedfmtraining.skillport.com.

;---------------------- Emergency Response Plan ------------------------------------------

:*:erpt::Improve the existing emergency response plan (ERP)

:*:erpr::The ERP should include the following positions:{Enter}Person-in-Charge - This person directs actions of personnel, is responsible for keeping the ERP roster current and ensuring personnel are trained.{Enter}Notifier - The notifier is designated to call the fire department.{Enter}Sprinkler Valve Operator - In the event of a fire, this person goes to the valve controlling the fire area and ensures it is open.{Enter}Utilities Operator - This person assists the fire department as needed to shut down utilities and hazardous processes.{Enter}Fire Pump Operator - The fire pump operator is designated to respond to the fire pump and ensure it is operating.{Enter}{Enter}Members of the emergency response team should be provided with quarterly refresher training.





; ==========================================================================================================================
; :*:reccom::
; { 
; hCtl := ControlGetClassNN(ControlGetFocus("A"))
; Ctl := ControlGethWnd(hCtl, "A")
; hWndChild := DllCall("RealChildWindowFromPoint", "Ptr", Ctl, "UInt", , "Ptr")
; cCtl := ControlGethWnd(, "ahk_pid " hwndChild)
; ;tooltip % "hCtl: " hCtl "`nCtl: " Ctl "`nhWndChild: " hWndChild "`nchWndChild: " chWndChild "`nErrorLevel: "ErrorLevel
; ;WinGetClass, vCtl, % "ahk_id " hWndChild
; ;msgbox % ASC("Control")
; ;return
; ;clipboard:=""
; ;txt:="Additional Boiler and Machinery (B&M) Minor Recommendations:"
; ;clipboard:= % txt
; ;clipwait 1

; DllCall("keybd_event", "int", 162, "int", 29, "int", 0, "int", 0)
; DllCall("keybd_event", "int", 0x42, "int", 0, "int", 0)
; DllCall("keybd_event", int, 0x42, int, 2, int, 0)
; DllCall("keybd_event", "int", 162, "int", 29, "int", 2, "int", 0)
; ;send ctrl+shift+left without using Send/SendInput/ControlSend
; ;e.g. tested on Notepad (Windows 7)
; ;WinGet, hWnd, ID, A
; ;ControlGetFocus, vCtlClassNN, % "ahk_id " hWnd
; ;if !(vCtlClassNN = "")
; ;ControlGet, hWnd, Hwnd,, % vCtlClassNN, % "ahk_id " hWnd

; ;vTIDAhk := DllCall("kernel32\GetCurrentThreadId", "UInt")
; ;VarSetCapacity(PBYTE1, 256, 0)
; ;DllCall("user32\GetKeyboardState", "Ptr",&PBYTE1)

; ;vTID := DllCall("user32\GetWindowThreadProcessId", "Ptr",hWnd, "Ptr",0, "UInt")
; ;DllCall("user32\AttachThreadInput", "UInt",vTIDAhk, "UInt",vTID, "Int",1)
; ;VarSetCapacity(PBYTE2, 256, 0)
; ;NumPut("UChar", 0x80, PBYTE2, 0x11) ;VK_CONTROL := 0x11
; ;NumPut("UChar", 0x80, PBYTE2, 0x42) ;VK_B := 0x42
; ;DllCall("user32\SetKeyboardState", "Ptr",&PBYTE2)

; ;WM_SYSKEYDOWN:=0x104, WM_SYSKEYUP:=0x105, WM_SYSCHAR:=0x106
; ;SendMessage,0x100, 0x11,,, % "ahk_id " hWnd ;WM_SYSKEYDOWN := 0x104 VK_CONTROL:= 0x11
; ;SendMessage, 0x100, 0x42,,, % "ahk_id " hWnd ;WM_SYSKEYDOWN := 0x104 VK_B:= 0x42
; ;SendMessage, 0x102, 0x42,,, % "ahk_id " hWnd ; WM_SYSCHAR:= 0x106, WM_CHAR:=0x102
; ; should be sent now
; ;SendMessage, 0x101, 0x42,,, % "ahk_id " hWnd ;WM_SYSKEYUP := 0x105, VK_B:= 0x42
; ;SendMessage, 0x101, 0x11,,, % "ahk_id " hWnd ;WM_SYSKEYUP := 0x105, VK_CONTROL:= 0x11
; ;DllCall("user32\AttachThreadInput", "UInt",vTIDAhk, "UInt",vTID, "Int",0)
; ;DllCall("user32\SetKeyboardState", "Ptr",&PBYTE1)
; ;Send "`n`n"
; ;clipboard:=""
; ;txt:="In addition to the formal B&M recommendations made, the following items also represent good loss prevention advice and should be completed."
; ;clipboard:=% txt
; ;clipwait 1
; ;send ^v
; ;clipboard:=""
; ;SendMessage, WM_KEYDOWN:=0x100, VK_CONTROL:=0x11, 0,,ahk_id %ctl%
; ;PostMessage, WM_CHAR, 0x00000062, 0x00300001,,ahk_ID %ctl%
; ;PostMessage, WM_KEYDOWN:=0x100, VK_B:=0x42, 0,,ahk_id %ctl%
; ;PostMessage, WM_CHAR, 0x00000062, 0x00300001,,ahk_ID %ctl%
; ;SendMessage, WM_KEYUP:=0x101, VK_B:=0x42, 0,,ahk_id %ctl%

; ;SendMessage, WM_KEYUP:=0x101,VK_CONTROL:=0x11, 0,,ahk_id %ctl%
; ;Send % chr(98)
; ;ControlSend, ,^b,"ahk_id " Ctl
; ;DllCall("SendMessage", "UInt", 0x0100, "UInt", 265, "UInt", 0x11, "UInt", 17) ; WM_KEYDOWN, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;DllCall("SendMessage", "UInt", 0x0100, "UInt", key: {Ctrl}) ; WM_KEYDOWN, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;MsgBox % ErrorLevel
; ;DllCall("SendMessage", "UInt", 0x0100, Int32, 265, Int32, 0x42) ; WM_KEYDOWN, Value,VK_B == Note: magnumbdb.com has nothing
; ;Sleep 100
; ;Send % txt
; ;DllCall("SendMessage", "UInt", 0x0101, "UInt", 257, "UInt", 0x42) ; WM_KEYUP, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;DllCall("SendMessage", "UInt", 0x0101, "UInt", 257, "UInt", 0x11, "UInt", 17) ; WM_KEYUP, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;Sleep 100
; ;Send "`n`n"
; ;Clipboard:=txt1:="In addition to the formal B&M recommendations made, the following items also represent good loss prevention advice and should be completed."
; ;Send ^v
; return
; } 

:*:recresp::
{ 
A_Clipboard:= ""
A_Clipboard := "Management stated they understand the recommendation. When the recommendation is received, the vendor will be engaged to ascertain the scope, cost, and scheduling. No timeline for completion was offered."

Send("^v")
Sleep(100)

} 

:*:eleclvt::
{ 
A_Clipboard:=""
A_Clipboard:= "Improve asset management of the low voltage switchgear."

Send("^v")
Sleep(100)

} 

:*:eleclvr::
{ 
A_Clipboard:=""
A_Clipboard:= "Improve inspection, testing, and maintenance (ITM) of the low voltage switchgear per" A_Space

Send("^v")
Sleep(100)
SendLevel(1)
;SetKeyDelay,100,10
Send("fmdsf")
Send("{Space}")
;SetKeyDelay,100,10
Send("5-20f")

} 

:*:eleclvd::
{ 
A_Clipboard:=""
A_Clipboard:= "
(
The following is summary of guidance in Data Sheet 5-20:

Low Voltage Circuit Breakers:
- Section 2.1.3.2, and Table 1.

Table 1:
Low Resistance:
- Measuring resistance across bolted connections
Insulation Resistance:
- Each pole measured phase to ground and phase to phase
Contact Resistance (micro-ohms):
- Measuring resistance across closed contacts
Primary, or secondary, current injection testing
Trip and close coil voltages (if applicable, compare with OEM values)

Motor Controllers:
- Section 2.1.3.3, and Table 2.

Bus Ducts and Cables:
- Section 2.1.3.6, and Table 5.

For full guidance on all applicable sections, please see Data Sheet 5-20.
)"

Send("^v")
Sleep(100)



; ================================== MV SWITCHGEAR  ==========================
} 
:*:mvswgrtit::
{ 
A_Clipboard:=""
Sleep(100)
A_Clipboard := "Improve asset management of the medium voltage switchgear."

Send("^v")
Sleep(100)

} 

:*:mvswgrrec::
{ 
A_Clipboard:="
(
During the visit, the following deficiency was identified:
- No formal ITM program exists; it is unknown if any recommended ITM has occurred since installation.
- The electrical single-line diagram was created in-house, is out-of-date, and some parts lack critical details such as the current interruption device types/styles (e.g., circuit breaker, switch, fused-switch, ampere rating).

The following is a summary of guidance outlined in Data Sheet 5-19, and includes:

Online: (annual)
Perform online partial discharge surveys every one to three years.

Offline: (every three years)

Circuit Breakers:
- Section 2.1.4.1, and Table 1a/1b.
Switches and Fuses:
- Section 2.1.4.2, and Table 2.
Protection Relays:
- Section 2.1.4.3
Insulators and Busbars:
- Section 2.1.4.6, and Table 4.

Additional Guidance:
- FM Global recommends and is available to review any service agreements (e.g., scope, periodicity, alternative methods) to ensure the intent of the recommendation is met prior to finalizing the maintenance contract and starting work.
- Once the service records/baseline values are obtained, maintain the records for review, tracking, and trend analysis; contact and provide the records to FM Global for review.

Please see the data sheet for full details and additional guidance.
)"

Send("^v")
Sleep(100)


; =================================================================
} 
:*:swgruth::
{ 
A_Clipboard:=""
Sleep(100)
A_Clipboard :="
(
The switchgear protects the electrical distribution and downstream production equipment. If this equipment fails to operate as intended, this exposure can result in significant business interruption, delays in testing/certification, loss of in-process and/or controlled storage products, and personnel safety.
)"

Send("^v")
Sleep(100)


; =========================== ECP STUFF ==================================
} 

:*:ecprinsr::Management stated they understand the recommendation, and have agreed to add the documents to the existing document review management program. Once the documents are added, reviewed, and updated, FM Global will be provided the documents, and contacted for review prior to closure of the recommendation. No formal timeline for completion was offered.


; ==================TRANSFORMERS ==============
:*:xfmrrec::
{ 
A_Clipboard:=""
Sleep(100)
A_Clipboard := "
(
The following guidance is outlined in Data Sheet 5-4 and includes:

Perform baseline/benchmark testing, as applicable, listed in Section 2.1.3.1.1. 

Perform the following electrical tests, listed in Table 2, at least once every three years:

Windings: 
- Insulation resistance
- Winding resistance
- Polarization index
- Turns ratio
- Power factor/capacitance

Bushings: 
- Power factor
- Capacitance testing

Core: 
- Core insulation resistance

Additional Guidance:
Note 1: If any issues are found during testing, Table 3 provides guidance for any additional focused testing requirements.
Note 2: Once baseline/benchmark testing has been completed please provide the results to, and contact, FM Global for review. 

Please see the data sheet for full details.
)"

Send("^v")
Sleep(100)


; ================ PARTIAL DISCHARGE SURVEYS ====================================
} 
:*:pdtitle::Implement an annual online partial discharge (PD) survey program.

:*:pdrec::
{ 
A_Clipboard:=""
Sleep(100)
A_Clipboard:= "Perform annual online partial discharge (PD) surveys for switchgear and circuit breakers rated 4 kV and above per "

Send("^v")
Sleep(100)
SetKeyDelay(100, 10)
Send("fmdsf")
Sleep(100)
Send("{Space}")
Sleep(100)
Send("5-19f")
Sleep(100)
Send(".`n`n`n")
A_Clipboard:=""
A_Clipboard := "Note: This recommendation is being made due to updated guidance, and associated industry loss history."

Send("^v")
Sleep(100)

} 

:*:pduth::
{
A_Clipboard := ""
A_Clipboard := "
(
    Partial discharge (PD) and corona activity occur in switchgear rated 4 kV and above and is a good indicator of insulation issues due to incorrect installation, manufacturer defects, and signs of aging. The switchgear protects the electrical distribution and downstream production equipment.
)"
Send('^v')
Sleep(100)

}

:*:pdtech::
{ 
A_Clipboard:= ""
Sleep(100)
A_Clipboard := "
(
There are multiple ways to meet the intent of this recommendation. Please utilize a specialized vendor to provide, and review with, the available options.

Partial Discharge (PD) Guidance:
Please see Data Sheet 5-19, Sections 3.2.3, and 3.2.4, for in-depth technical details regarding methods of testing, and continuous monitoring vs. in-service survey PD testing.
)"
Send("^v")
Sleep(100)
SetKeyDelay(100, 10)
Send("{Up}")
Sleep(100)
Send("{LShift Down}{Home}{LShift Up}")
Sleep(100)
Send("^#b")


; ============================ BATTERY STUFF =====================
} 
:*:battitmt::
{ 
A_Clipboard:= ""
Sleep(100)
A_Clipboard := "Improve inspection, testing, and maintenance (ITM) of medium voltage (MV) switchgear batteries."
Send("^v")
Sleep(100)

} 
:*:battmgmt::
{ 
A_Clipboard:= ""
Sleep(100)
A_Clipboard := "Improve asset management of medium voltage (MV) switchgear batteries."
Send("^v")
Sleep(100)

} 
:*:battrec::
{ 
A_Clipboard:=""
Sleep(100)
A_Clipboard := "Improve the management of medium voltage (MV) switchgear batteries per "
Send("^v")
Sleep(100)
SetKeyDelay(100, 10)
Send("fmdsf")
Sleep(100)
Send("{Space}")
Send("5-28f")
Sleep(100)
Send(".`n`n")
A_Clipboard := "
(
- Perform quarterly capacitance (internal ohmic) testing
- Perform five year capacity (performance or discharge) testing
- Monitor, maintain, and control battery room/area temperature at, or near, 77°F
)"

Send("^v")
Sleep(100)

} 
:*:battuth::
{ 
A_Clipboard := "Switchgear batteries are critical safety devices, and provide the trip voltage necessary to open the breaker(s) in a fault condition. Monitoring and controlling the temperature of the batter room/area, at/near 77°F, is also critical to overall battery life and health. Deterioration of the batteries affects the circuit breaker's arc-interrupting capability."

Sleep(100)
Send("^v")
Sleep(100)

} 

:*:battitmf::
{ 
A_Clipboard:= "
(
The following guidance is outlined in Data Sheet 5-28:

Capacitance (Internal Ohmic) Testing: (see Note 1)
Section 2.5.2 and Table 1: Capacitance testing, maintenance schedule, and other useful information.
- Capacitance, internal ohmic, internal resistance, and internal impedance, are common terms that are synonymous.
- This requires a specific type of testing equipment, and cannot be done with a standard multimeter; a multimeter will provide resistance readings, but this is not the same as internal resistance.

Capacity (Performance or Discharge) Testing: (see Note 2)
Section 2.5.2.4: Periodicity of capacity testing based on battery type, and other useful information.

Failure Modes:
Section 3.3.3 and Table 2: Provides pictures and technical detail on major failure modes of flooded/vented lead acid (VLA) batteries (e.g., sulfating).

Alternatives:
- Note 1: If all of Section 2.3.6.2 (as applicable) parameters are monitored, annual capacitance (internal ohmic) testing is acceptable. The continuously monitored parameters should match Table 1; whatever is not continuously monitored, perform at regular recommended periodicity.  
- Note 2: If all of Table 1, including internal ohmic, is performed, and some additional conditions met (detailed below), it is acceptable not to perform capacity (performance or discharge) testing, due to the battery's application.
- Must meet all of the following conditions: Baseline values are recorded at the recommended intervals; the same testing equipment is utilized throughout battery life; a prescriptive failing/failed battery replacement/capacity testing program is developed, and followed; the batteries do not support any loads other than the medium voltage switchgear, and its associated protective features.

Please see the data sheet for full guidance details.
)"
Send("^v")

} 

:*:battmgmf::
{ 
A_Clipboard := "
(
The following guidance is outlined in Data Sheet 5-28:

Temperature Control and Monitoring:
- Section 2.3.1.1: To optimize the performance and aging rate of the batteries, maintain the battery room, or area, as close to 77°F (25°C), or temperature range specified by manufacturer, as possible.
- Section 3.3.2: Provides additional technical detail on temperature control and reduced life.
- This section also includes the critical statement: Continuous operation of batteries at elevated temperature will reduce the life by approximately 50% for every increase of 15°F (8.3°C).

Please see the data sheet for full guidance details.
)"

Sleep(100)
Send("^v")
Sleep(100)

} 

:*:battresp::
{ 
A_Clipboard := "Management stated they understand the recommendation. An assessment will be conducted internally if performing this in-house is practical, or if the existing vendor will be used; if performed in-house, the appropriate battery tester will be purchased as soon as practical, and capacitance testing will begin. No formal timeline for completion was offered."

Sleep(100)
Send("^v")
Sleep(100)
}
