-- Exploratory data analysis : exploring the laid off data (total_laid-off and percentgae_laid_off) in order to find the useful insights(trends) in it.

select * from layoff_stage_dup; 

 -- Finding the companies that had laid off of all the employees percentage laid off =1(100%) : 
  select * from layoff_stage_dup where percentage_laid_off = 1 ; 

 -- Finding the companies that had the highest number of laid off : 
select * from layoff_stage_dup where percentage_laid_off = 1 order by total_laid_off desc ;

  -- Finding the total laid off of each companies :
  select company, sum(total_laid_off) as laid_off from layoff_stage_dup group by company  ; 
   select company, sum(total_laid_off) as laid_off from layoff_stage_dup group by company order by 2 desc  ; 
   
-- To know the time period of layoff:
select min(`date`) as starting_date, max(`date`) as ending_date from layoff_stage_dup ; 

-- Industries that had the highest layoff:
select industry,sum(total_laid_off) as layoff_industry from layoff_stage_dup group by industry ;
 select industry,sum(total_laid_off) as layoff_industry from layoff_stage_dup group by industry order by 2 desc ;
 
 -- Countries that had the highest layoff:
 select country,sum(total_laid_off) as layoff_country from layoff_stage_dup group by country ;
  select country,sum(total_laid_off) as layoff_country from layoff_stage_dup group by country order by 2 desc  ;

-- Find layoffs with individual date:
select `date`, sum(total_laid_off) as date_layoff from layoff_stage_dup group by `date` ;
  select `date`, sum(total_laid_off) as date_layoff from layoff_stage_dup group by `date` order by 2 desc; 

-- Find the layoffs of the recent dates :
  select `date`, sum(total_laid_off) as date_layoff from layoff_stage_dup group by `date` order by 1 desc;
  
 -- Find the layoffs by each year :
 select year(`date`) as YEARS, sum(total_laid_off) as year_layoff from layoff_stage_dup  group by YEARS ;
  
  -- year that has the highest layoff:
    select year(`date`) as YEARS, sum(total_laid_off) as year_layoff from layoff_stage_dup  group by YEARS order by year_layoff desc ;

 -- recent years layoff:
  select year(`date`) as YEARS, sum(total_laid_off) as year_layoff from layoff_stage_dup  group by YEARS order by YEARS desc ;

select * from layoff_stage_dup; 

-- Finding the layoffs with stage of the company(each stage):
select stage,sum(total_laid_off) as stage_layoff from layoff_stage_dup group by stage ;

-- Finding which stage has most layoffs:
select stage,sum(total_laid_off) as stage_layoff from layoff_stage_dup group by stage order by stage_layoff desc; 

-- finding progreesion of layoff ( rolling sum) of layoffs with month:
select substring(`date`,1,7) as monthly , sum(total_laid_off) as monthly_layoff from layoff_stage_dup  group by monthly;
 select substring(`date`,1,7) as monthly , sum(total_laid_off) as monthly_layoff from layoff_stage_dup where month(`date`) is not null group by monthly;
  select substring(`date`,1,7) as monthly , sum(total_laid_off) as monthly_layoff from layoff_stage_dup 
  where month(`date`) is not null group by monthly order by monthly asc;
  
with rolling_sum as
( 
select substring(`date`,1,7) as monthly , sum(total_laid_off) as monthly_layoff from layoff_stage_dup 
  where month(`date`) is not null group by monthly order by monthly asc
  ) select monthly, sum(monthly_layoff) over( order by monthly) as roll_sum from rolling_sum;
  
  -- Find in which year the company has laid off most:
  select * from layoff_stage_dup;
  
   select company, year(`date`) as YEARS,sum(total_laid_off) from layoff_stage_dup group by company 
  , YEARS order by company asc;
  
  select company, year(`date`) as YEARS,sum(total_laid_off) from layoff_stage_dup group by company 
  , YEARS order by company asc;
  
  select company, year(`date`) as YEARS,sum(total_laid_off) from layoff_stage_dup group by company 
  , YEARS order by 3 desc;
  
  with companies_rank (COMPANY,YEARS,LAID_OFF) as
  (
  select company, year(`date`) as YEARS,sum(total_laid_off) from layoff_stage_dup group by company 
  , YEARS ) select *, dense_rank() over( partition by years order by LAID_OFF desc) as 
  RANKING from companies_rank where YEARS IS NOT NULL ;
  
  -- find the companies (top 5 companies) which has laid off most in each year:
  with companies_rank1 (COMPANY,YEARS,LAID_OFF) as
  (
  select company, year(`date`) as YEARS,sum(total_laid_off) from layoff_stage_dup group by company 
  , YEARS ), companies_year as (select *, dense_rank() over( partition by years order by LAID_OFF desc) as 
  RANKING from companies_rank1 where YEARS IS NOT NULL) select * from companies_year where RANKING <=5 ; 
  
  -- -- Find in which year the industries has laid off most:
  with industries_rank (INDUSTRY,YEARS,LAID_OFF) as
  (
  select industry, year(`date`) as YEARS,sum(total_laid_off) from layoff_stage_dup group by industry
  , YEARS ) select *, dense_rank() over( partition by years order by LAID_OFF desc) as 
  RANKING from industries_rank where YEARS IS NOT NULL ;
  
  -- -- find the industries (top 5 industries) which has laid off most in each year:
  with industries_rank1 (INDUSTRY,YEARS,LAID_OFF) as
  (
  select industry, year(`date`) as YEARS,sum(total_laid_off) from layoff_stage_dup group by industry
  , YEARS ), industry_year as (select *, dense_rank() over( partition by years order by LAID_OFF desc) as 
  RANKING from industries_rank1 where YEARS IS NOT NULL ) select * from industry_year where RANKING<=5; 