SELECT sky, count(sky) as count
FROM weather
GROUP BY sky
ORDER BY count;

UPDATE weather
SET sky = 'M'
WHERE sky IN ('MIFG','PRFG','VCFG','FZFG','DZ','-DZ VCTS','HZ FU',
			'BLDU','VCBLDU','FU','BCFG','SQ''DU')
;

UPDATE weather
SET sky = CASE
    WHEN sky LIKE '%+RA%' OR sky LIKE '%+TS%' OR sky LIKE '+SH%' THEN 'hvy_precip'
    
    WHEN sky LIKE '%-RA%' OR sky LIKE '%-TS%' OR sky LIKE '%-SN%'
		OR sky LIKE '%VC%' OR sky LIKE '%DZ%' THEN 'lt_precip'
        
    WHEN sky LIKE '%RA%' OR sky LIKE '%TS%' OR sky LIKE '%SH%' THEN 'med_precip'
    
    WHEN sky LIKE '%HZ%' OR sky LIKE '%FG%' OR sky LIKE 'BR' THEN 'shaded'
    
    WHEN sky = 'M' THEN 'clear'
    ELSE sky
END;
