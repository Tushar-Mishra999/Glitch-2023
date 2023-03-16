const COMPANY_CODES = {
    'IndianTimes' : 'scraperIT',
    'TheEconomicTimes' : 'scraperET',
    'TheHindu' : 'scraperTH',
    'BusinessToday' : 'scraperBT',
    'MoneyControl' : 'scraperMC',
    'TimesNow' : 'scraperTN',
    'LiveMint' : 'scraperLM',
    'BusinessStandard' : 'scraperBS',
    'ZeeBusiness' : 'scraperZB',
    'FinancialExpress' : 'scraperFE',
}

// const companyCode = 

switch (companyCode) {
    case 'IndianTimes':
        COMPANY_CODES.IndianTimes();
        break;

    case 'TheEconomicTimes':
        COMPANY_CODES.TheEconomicTimes();
        break;    

    case 'TheHindu':
        COMPANY_CODES.TheHindu()
        break;
    
    case 'BusinessToday':
        COMPANY_CODES.BusinessToday()
        break;
    
    case 'MoneyControl':
        COMPANY_CODES.MoneyControl()
        break;
    
    case 'TimesNow':
        COMPANY_CODES.TimesNow()
        break;
    
    case 'LiveMint':
        COMPANY_CODES.LiveMint();
        break;
    
    case 'BusinessStandard':
        COMPANY_CODES.BusinessStandard();
        break;

    case 'ZeeBusiness':
        COMPANY_CODES.ZeeBusiness();
        break;
    
    case 'FinancialExpress':
        COMPANY_CODES.FinancialExpress();
        break;
    
    default:
        console.log("Invalid");
        break;
}