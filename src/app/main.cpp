#include <iceoryx_posh/popo/untyped_publisher.hpp>
#include <memory>

int main() {
  iox::runtime::PoshRuntime::initRuntime("pub");
  std::string name{"name"};
  auto iox_name = iox::cxx::string<100>{iox::cxx::TruncateToCapacity_t{}, name};
  auto desc = iox::capro::ServiceDescription{"tmp", iox_name, "tmp"};

  iox::popo::PublisherOptions options;
  options.subscriberTooSlowPolicy = iox::popo::ConsumerTooSlowPolicy::DISCARD_OLDEST_DATA;
  options.historyCapacity = 5;

  auto pub = std::make_shared<iox::popo::UntypedPublisher>(desc, options);
  std::size_t serialized_size = 10000;
  pub->loan(serialized_size, alignof(char)).and_then([&](auto&) {});
  return 0;
}
