from pytube import YouTube

video_url=input("Digite o Link do video do Youtube: ")
yt = YouTube(video_url)
stream = yt.streams.get_highest_resolution()
stream.download()

print("Download Concluido !!")