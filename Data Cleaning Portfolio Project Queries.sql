/*

Cleaning Data in SQL Queries

*/

SELECT *
FROM PortfolioProject..NashvillelHousing

--------------------------------------------------------------------------------------------------------------------------


-- Standardize Date Format

SELECT SaleDateConverted, CONVERT(date,SaleDate)
FROM PortfolioProject..NashvillelHousing

UPDATE PortfolioProject..NashvillelHousing
SET SaleDate = CONVERT(date,SaleDate)


-- If it doesn't Update properly

ALTER TABLE PortfolioProject..NashvillelHousing
Add SaleDateConverted Date;

UPDATE PortfolioProject..NashvillelHousing
SET SaleDateConverted = CONVERT(date,SaleDate)

 --------------------------------------------------------------------------------------------------------------------------



-- Populate Property Address data

Select *
From PortfolioProject..NashvillelHousing
--Where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvillelHousing a
JOIN PortfolioProject..NashvillelHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvillelHousing a
JOIN PortfolioProject..NashvillelHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


--------------------------------------------------------------------------------------------------------------------------


-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject..NashvillelHousing
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From PortfolioProject..NashvillelHousing


ALTER TABLE PortfolioProject..NashvillelHousing
Add PropertySplitAddress Nvarchar(255);

Update PortfolioProject..NashvillelHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE PortfolioProject..NashvillelHousing
Add PropertySplitCity Nvarchar(255);

Update PortfolioProject..NashvillelHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))



Select *
From PortfolioProject..NashvillelHousing



Select OwnerAddress
From PortfolioProject..NashvillelHousing


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProject..NashvillelHousing




ALTER TABLE PortfolioProject..NashvillelHousing
Add OwnerSplitAddress Nvarchar(255);

Update PortfolioProject..NashvillelHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE PortfolioProject..NashvillelHousing
Add OwnerSplitCity Nvarchar(255);

Update PortfolioProject..NashvillelHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE PortfolioProject..NashvillelHousing
Add OwnerSplitState Nvarchar(255);

Update PortfolioProject..NashvillelHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From PortfolioProject..NashvillelHousing



--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvillelHousing
Group by SoldAsVacant
order by 2



Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject..NashvillelHousing


Update PortfolioProject..NashvillelHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

-----------------------------------------------------------------------------------------------------------------------------------------------------------


 -- Removing  Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) as row_num

From PortfolioProject..NashvillelHousing
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

--Use delete instead of select * to remove duplicates after creating a CTE



Select *
From PortfolioProject..NashvillelHousing



---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns


Select *
From PortfolioProject..NashvillelHousing


ALTER TABLE PortfolioProject..NashvillelHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate


