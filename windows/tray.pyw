from PIL import Image
from multiprocessing import Process, Queue
from pystray import Icon as icon
from pystray import MenuItem as item
import pyperclip
import pystray
import subprocess
import time


def func1(q):
    if (not q.empty()) and str(q.get()) == 'stop':
        return False
    pass


def action():
    icon.stop()
    q.put('stop')


def delete():
    pyperclip.copy('')


global dtime
dtime = time.time()


def _delete():
    global dtime
    if time.time() - dtime < 0.3:
        pyperclip.copy('')
        # icon.notify('삭제')
    dtime = time.time()
    print(dtime)


def audio():
    subprocess.call('powershell Get-AudioDevice -List', shell=True)
    subprocess.call('powershell Set-AudioDevice -Index 3', shell=True)
    subprocess.call('powershell Set-AudioDevice -Index 1', shell=True)


if __name__ == '__main__':
    q = Queue()
    p_func1 = Process(target=func1, args=(q,))
    p_func1.start()

    # image = Image.open('avatar_profile.png')
    image = Image.open('C:\\Users\\loonatic\\avatar_profile.png')
    menu = pystray.Menu(item('삭제', _delete, default=True, visible=False),
                        item('오디오', audio), item('삭제', delete),
                        item('종료', action))

    icon = pystray.Icon("name", image, "클릭", menu=menu)
    icon.run()

    q.close()
    q.join_thread()
