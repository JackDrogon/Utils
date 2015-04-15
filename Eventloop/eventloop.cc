#include <string>
#include <queue>

#include <sys/types.h>
#include <sys/time.h>
#include <unistd.h>

// TODO: use map

class EventLoop {
public:
	struct FileEvent {
	};

	EventLoop()
	{
	}

	static EventSet()
	{
	}

	AddEvent();
	AddFileEvent();
	AddTimeEvent();

	void Main()
	{
	}

private:
	std::queue<> timequeue_;
	std::queue<> writequeue_;
	std::queue<> readqueue_;
	std::queue<>
};

#ifdef UNIT_TEST
int main()
{
	EventLoop event_loop;
	event_loop.AddEvent();
	event_loop.Main();
}
#endif
