#include <iostream>
#include <random>
#include <vector>
#include <algorithm>
#include <cmath>
#include <numeric>
#include <ctime>

double getSkewness(std::vector<double>& data) {
	double avg = std::accumulate(data.begin(), data.end(), 0.0) / data.size();
	double sum1 = 0.0;
	double sum2 = 0.0;
	for (double num : data) {
		sum1 += pow(num - avg, 3);
		sum2 += pow(num - avg, 2);
	}
	double stdev = sqrt(sum2 / data.size());
	return sum1 / ((data.size() - 1) * pow(stdev, 3));
}

int main() {

	std::default_random_engine engine(time(NULL));
	std::vector<double> data(100);

	std::cout << "compute the skewness of normal distribution ..." << std::endl;
	std::normal_distribution<double> nd(40, 10);
	for (std::size_t i = 0; i < data.size(); ++i) {
		data[i] = nd(engine);
	}
	std::cout << "the skewness of normal distribution is " << getSkewness(data) << std::endl;

	std::cout << std::endl;

	std::cout << "compute the skewness of binomial distribution ..." << std::endl;
	std::binomial_distribution<int> bd(1, 0.5);
	for (std::size_t i = 0; i < data.size(); ++i) {
		data[i] = bd(engine);
	}
	std::cout << "the skewness of binomial distribution is " << getSkewness(data) << std::endl;

	std::cout << std::endl;

	std::cout << "compute the skewness of negative binomial distribution ..." << std::endl;
	std::negative_binomial_distribution<int> nbd(1, 0.5);
	for (std::size_t i = 0; i < data.size(); ++i) {
		data[i] = nbd(engine);
	}
	std::cout << "the skewness of negative binomial distribution is " << getSkewness(data) << std::endl;

	system("pause");
	return 0;
}