create database Nykaa_Marketing_Database;
select * from nykaa_cleaned_data;

-- Q1: Where should we reallocate budget?
SELECT
    Campaign_Type,
    ROUND(AVG(ROI), 1) AS Avg_ROI,
    SUM(Revenue) AS Total_Revenue,
    ROUND(SUM(Acquisition_Cost), 1) AS Total_Spend,
    COUNT(*) AS Campaigns
FROM nykaa_cleaned_data
GROUP BY Campaign_Type
ORDER BY Avg_ROI DESC;

-- Q2: Are we acquiring customers efficiently?
SELECT
    Campaign_Type,
    ROUND(AVG(Acquisition_Cost), 1) AS Avg_Cost,
    ROUND(AVG(ROI), 1) AS Avg_ROI
FROM nykaa_cleaned_data
GROUP BY Campaign_Type
ORDER BY Avg_Cost DESC;

-- Q3: Which audience segments over/under-perform?
SELECT
    Target_Audience,
    SUM(Revenue) AS Total_Revenue,
    ROUND(AVG(ROI), 2) AS Avg_ROI,
    ROUND(AVG(Engagement_Score), 2) AS Avg_Engagement,
    COUNT(*) AS Campaigns
FROM nykaa_cleaned_data
GROUP BY Target_Audience
ORDER BY Total_Revenue DESC;

-- Q4: Where is the biggest funnel leak?
SELECT
    SUM(Impressions) AS Total_Impressions,
    SUM(Clicks) AS Total_Clicks,
    SUM(Leads) AS Total_Leads,
    SUM(Conversions) AS Total_Conversions,
    ROUND(SUM(Clicks) / SUM(Impressions) * 100, 2) AS Click_Rate_pct,
    ROUND(SUM(Leads) / SUM(Clicks) * 100, 2) AS Lead_Rate_pct,
    ROUND(SUM(Conversions) / SUM(Leads) * 100, 2) AS Conversion_Rate_pct
FROM nykaa_cleaned_data;

-- Q5: Which group of Campaign Type, Language, and Target Audience gives the best average ROI?
SELECT
    Campaign_Type,
    Language,
    Target_Audience,
    ROUND(AVG(ROI), 2) AS Avg_ROI,
    COUNT(*) AS Campaigns,
    SUM(Revenue) AS Total_Revenue
FROM nykaa_cleaned_data
GROUP BY Campaign_Type, Language, Target_Audience
HAVING COUNT(*) >= 30
ORDER BY Avg_ROI DESC
LIMIT 10;
