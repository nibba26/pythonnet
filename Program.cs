using System;
using Python.Runtime;

class Program
{
    static void Main(string[] args)
    {
        // Python 인터프리터 경로 설정
        var pythonHome = "/usr/bin"; // Python 설치 경로 확인 후 설정
        Environment.SetEnvironmentVariable("PYTHONHOME", pythonHome);
        Environment.SetEnvironmentVariable("PYTHONPATH", $"/usr/lib/python3/dist-packages");
        Runtime.PythonDLL = "/usr/lib/python3.11/config-3.11-x86_64-linux-gnu/libpython3.11.so";
        // Python.Runtime 초기화
        PythonEngine.Initialize();

        try
        {
            using (Py.GIL())
            {
                dynamic sys = Py.Import("sys");
                Console.WriteLine($"Python version: {sys.version}");

                // Python 코드 실행
                dynamic os = Py.Import("os");
                Console.WriteLine($"Current directory: {os.getcwd()}");
            }
        }
        finally
        {
            PythonEngine.Shutdown();
        }
    }
}