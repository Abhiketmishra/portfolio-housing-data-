--table 
select * from nashvillehousing


-- updaing date data type

alter table nashvillehousing
add SaleDateconverted date;

update nashvillehousing 
set SaleDateconverted =convert(date, saledate );

select SaleDateconverted
from nashvillehousing;



--update property address
update a
set PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
from portfolio..nashvillehousing a, portfolio..nashvillehousing b
where a.ParcelID = b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
and a.PropertyAddress is null


--breaking out propertyaddress into individual column(address,city,state)
select SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress,1)-1) as address,
substring (PropertyAddress, CHARINDEX(',',PropertyAddress,1)+1,len(PropertyAddress)) as city
from portfolio..nashvillehousing



--updating in table adress and city
alter table nashvillehousing
add splitpropertyaddress varchar(225), city varchar(225);
update nashvillehousing
set splitpropertyaddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress,1)-1),
city=substring (PropertyAddress, CHARINDEX(',',PropertyAddress,1)+1,len(PropertyAddress))



--breaking out owneraddress into individual column(address,city,state)
select OwnerAddress,PARSENAME(replace(OwnerAddress,',','.'),3) as splitowneraddress,
PARSENAME(replace(OwnerAddress,',','.'),2) as ownercity,
PARSENAME(replace(owneraddress,',','.'),1) as ownerstate
from portfolio..nashvillehousing
where OwnerAddress is not null



--updating the breaking out owneraddress into individual column(address,city,state)
alter table nashvillehousing
add splitowneraddress varchar(225), ownerstate varchar(225), ownercity varchar(225);

update nashvillehousing
set splitowneraddress=PARSENAME(replace(OwnerAddress,',','.'),3) ,
ownercity=PARSENAME(replace(OwnerAddress,',','.'),2) ,
ownerstate=PARSENAME(replace(owneraddress,',','.'),1)
where owneraddress is not null


--change Y and n to yes AND no in sold as vacant field
select distinct(SoldAsVacant),count(soldasvacant)
from nashvillehousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case when SoldAsVacant='y' then 'yes'
     when SoldAsVacant='n' then 'no'
	 else SoldAsVacant
	 end
from nashvillehousing

update nashvillehousing
set SoldAsVacant=case when SoldAsVacant='y' then 'yes'
     when SoldAsVacant='n' then 'no'
	 else SoldAsVacant
	 end
from nashvillehousing



