///Should return a /datum/export_report if overriden
/atom/movable/proc/supply_export(faction_selling)
	return 0

/obj/item/reagent_containers/food/snacks/mre_pack/meal4/req/supply_export(faction_selling)
	SSpoints.supply_points[faction_selling] += 1
	return new /datum/export_report(1, name, faction_selling)

/mob/living/carbon/xenomorph/supply_export(faction_selling)
	switch(tier)
		if(XENO_TIER_MINION)
			. = 5
		if(XENO_TIER_ZERO)
			. = 15
		if(XENO_TIER_ONE)
			. = 30
		if(XENO_TIER_TWO)
			. = 40
		if(XENO_TIER_THREE)
			. = 50
		if(XENO_TIER_FOUR)
			. = 100
	SSpoints.supply_points[faction_selling] += .
	return new /datum/export_report(., name, faction_selling)

/mob/living/carbon/xenomorph/shrike/supply_export(faction_selling)
	SSpoints.supply_points[faction_selling] += 50
	return new /datum/export_report(50, name, faction_selling)


/mob/living/carbon/human/supply_export(faction_selling)
	if(!can_sell_human_body(src, faction_selling))
		return new /datum/export_report(0, name, faction_selling)
	switch(job.job_category)
		if(JOB_CAT_CIVILIAN)
			. = 1
		if(JOB_CAT_ENGINEERING, JOB_CAT_MEDICAL, JOB_CAT_REQUISITIONS)
			. = 15
		if(JOB_CAT_MARINE)
			. = 10
		if(JOB_CAT_SILICON)
			. = 80
		if(JOB_CAT_COMMAND)
			. = 100
	SSpoints.supply_points[faction_selling] += .
	return new /datum/export_report(., name, faction_selling)

/// Return TRUE if the relation between the two factions are bad enough that a bounty is on the human_to_sell head
/proc/can_sell_human_body(mob/living/carbon/human/human_to_sell, seller_faction)
	var/to_sell_alignement = GLOB.faction_to_alignement[human_to_sell.faction]
	switch(to_sell_alignement)
		if(ALIGNEMENT_NEUTRAL) //No one hates neutral
			if(seller_faction == human_to_sell.faction)
				return TRUE
			return TRUE
		if(ALIGNEMENT_HOSTILE) // Can always sell an hostile unless you are of the same faction
			if(seller_faction == human_to_sell.faction)
				return TRUE
			return TRUE
		if(ALIGNEMENT_FRIENDLY)
			if(seller_faction == human_to_sell.faction)
				return TRUE
			return TRUE

/mob/living/carbon/human/species/robot/supply_export(faction_selling)
	SSpoints.supply_points[faction_selling] += 45
	return new /datum/export_report(45, name, faction_selling)
