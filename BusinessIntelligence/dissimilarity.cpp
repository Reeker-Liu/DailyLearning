#include <iostream>
#include <random>
#include <vector>
#include <algorithm>
#include <cmath>
#include <numeric>
#include <ctime>
#include <string>

enum CPUModel {
	A10 = 0,
	Kirin970,
	A11,
	Qualcomm845,
	Kirin980,
	A12,
	MAX
};

struct Phone
{
public:
	Phone(std::string name, int price, int batteryCapacity, int memoryCapacity, int storageCapacity, 
		double sizeOfScreen, CPUModel cpuModel, bool support2SIMs, bool supportFastCharge, 
		std::string operatingSystem, std::string brand)
		: name(name), price(price), batteryCapacity(batteryCapacity), memoryCapacity(memoryCapacity), storageCapacity(storageCapacity),
		sizeOfScreen(sizeOfScreen), cpuModel(cpuModel), support2SIMs(support2SIMs), supportFastCharge(supportFastCharge),
		operatingSystem(operatingSystem), brand(brand){	}

	std::string name;
	//numeric attributes
	int price;
	int batteryCapacity;
	int memoryCapacity;		//most used
	int storageCapacity;		//most used
	double sizeOfScreen;

	//ordinal attributes
	CPUModel cpuModel;

	//binary attributes
	bool support2SIMs;
	bool supportFastCharge;

	//Nominal attributes
	std::string operatingSystem;
	std::string brand;
};

void computeDissimilarity(std::vector<Phone>& phones) {
	//For simplicity, suppose the attributes of all data exists and there is no case such that asymmetric binary attributes are all false.
	//That is, the indicator is always 1
	int maxPrice = 0, minPrice = INT_MAX;
	int maxBattery = 0, minBattery = INT_MAX;
	int maxMemory = 0, minMemory = INT_MAX;
	int maxStorage = 0, minStorage = INT_MAX;
	double maxScreen = 0, minScreen = INT_MAX;
	
	for (auto phone : phones) {
		if (phone.price > maxPrice)
			maxPrice = phone.price;
		else if (phone.price < minPrice)
			minPrice = phone.price;
		if (phone.batteryCapacity > maxBattery)
			maxBattery = phone.batteryCapacity;
		else if (phone.batteryCapacity < minBattery)
			minBattery = phone.batteryCapacity;
		if (phone.memoryCapacity > maxMemory)
			maxMemory = phone.memoryCapacity;
		else if (phone.memoryCapacity < minMemory)
			minMemory = phone.memoryCapacity;
		if (phone.storageCapacity > maxStorage)
			maxStorage = phone.storageCapacity;
		else if (phone.storageCapacity < minStorage)
			minStorage = phone.storageCapacity;
		if (phone.sizeOfScreen > maxScreen)
			maxScreen = phone.sizeOfScreen;
		else if (phone.sizeOfScreen < minScreen)
			minScreen = phone.sizeOfScreen;
	}

	printf("          ");
	for (auto phone : phones) {
		printf("%-10s", phone.name.c_str());
	}
	printf("\n");
	for (size_t i = 0; i < phones.size(); ++i) {
		printf("%-10s", phones[i].name.c_str());
		for (size_t j = 0; j < phones.size(); ++j) {
			if (i > j) {
				const size_t numOfAttributes = 10;
				std::vector<double> res(numOfAttributes);
				res[0] = (double)abs(phones[i].price - phones[j].price) / (maxPrice - minPrice);
				res[1] = (double)abs(phones[i].batteryCapacity - phones[j].batteryCapacity) / (maxBattery - minBattery);
				res[2] = (double)abs(phones[i].memoryCapacity - phones[j].memoryCapacity) / (maxMemory - minMemory);
				res[3] = (double)abs(phones[i].storageCapacity - phones[j].storageCapacity) / (maxStorage - minStorage);
				res[4] = abs(phones[i].sizeOfScreen - phones[j].sizeOfScreen) / (maxScreen - minScreen);

				res[5] = abs((double)phones[i].cpuModel / (CPUModel::MAX - 1) - (double)phones[j].cpuModel / (CPUModel::MAX - 1));

				res[6] = phones[i].support2SIMs ^ phones[j].support2SIMs;
				res[7] = phones[i].supportFastCharge ^ phones[j].supportFastCharge;

				res[8] = phones[i].operatingSystem != phones[j].operatingSystem;
				res[9] = phones[i].brand != phones[j].brand;

				printf("%-10.3f", std::accumulate(res.begin(), res.end(), 0.0f) / numOfAttributes);

			}
			else
				printf(" ---      ");
		}
		printf("\n");
	}
	
}

int main() {

	std::vector<Phone> phones{
		Phone("iphoneX", 6898, 2716, 3, 64, 5.8f, CPUModel::A11, true, true, "iOS", "APPLE"),
		Phone("iphone7", 3628, 1960, 2, 32, 4.7f, CPUModel::A10, false, false, "iOS", "APPLE"),
		Phone("Mi8", 2499, 3400, 6, 64, 6.21f, CPUModel::Qualcomm845, true, true, "Android", "Mi"),
		Phone("HUAWEIP20", 3388, 3400, 6, 64, 5.8f, CPUModel::Kirin970, true, true, "Android", "HUAWEI")
	};

	computeDissimilarity(phones);

	system("pause");
	return 0;
}