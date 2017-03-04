package turanmahmudov.wallpapers;

import android.media.MediaScannerConnection;
import android.os.Bundle;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;

public class WallpapersInJava extends org.qtproject.qt5.android.bindings.QtActivity
{
    public static MediaScannerConnection s_mMs;

    private static NotificationManager m_notificationManager;
    private static Notification.Builder m_builder;
    private static WallpapersInJava m_instance;

    public WallpapersInJava()
    {
        m_instance = this;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        System.out.println("in the activity");

        super.onCreate(savedInstanceState);

        s_mMs = new MediaScannerConnection(getApplicationContext(), null);
        s_mMs.connect();

    }

    public static void scanForPicture(String name)
    {
        System.out.print("scan for picture -> ");
        System.out.println(name);

        s_mMs.scanFile(name, null);
    }

    public static void notify(String s)
    {
        if (m_notificationManager == null) {
            m_notificationManager = (NotificationManager)m_instance.getSystemService(Context.NOTIFICATION_SERVICE);
            m_builder = new Notification.Builder(m_instance);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setContentTitle("Wallpapers");
        }

        m_builder.setContentText(s);
        m_notificationManager.notify(1, m_builder.build());
    }
}
