**Create MIG scaling based on schedules**

Schedule-based autoscaling lets you improve the availability of your
workloads by scheduling capacity ahead of anticipated load. If you run
your workload on a managed instance group (MIG), you can schedule a
required number of virtual machine (VM) instances for recurring load
patterns as well as one-off events. Use scaling schedules if your
workload takes a long time to initialize and you want to scale out in
advance of anticipated load spikes.

This document describes how you can create, list, edit, disable,
re-enable, and delete scaling schedules for an existing MIG. For more
information about MIGs and autoscaling, see [[Creating managed instance
groups]{.underline}](https://cloud.google.com/compute/docs/instance-groups/creating-groups-of-managed-instances) and [[Autoscaling
groups of
instances]{.underline}](https://cloud.google.com/compute/docs/autoscaler).

**Before you begin**

-   If you want to use the command-line examples in this guide, do the
    following:

    1.  Install or update to the latest version of the [[Google Cloud
        CLI]{.underline}](https://cloud.google.com/compute/docs/gcloud-compute).

    2.  [[Set a default region and
        zone]{.underline}](https://cloud.google.com/compute/docs/gcloud-compute#set_default_zone_and_region_in_your_local_client).

-   If you want to use the API examples in this guide, [[set up API
    access]{.underline}](https://cloud.google.com/compute/docs/api/prereqs).

-   Read about
    autoscaler [[fundamentals]{.underline}](https://cloud.google.com/compute/docs/autoscaler#fundamentals).

**Limitations**

Scaling schedules are restricted by the [[limitations for all
autoscalers]{.underline}](https://cloud.google.com/compute/docs/autoscaler#specifications) as
well as the following limitations:

-   You can have up to 128 scaling schedules per MIG. To mitigate this
    limit, delete scaling schedules that have an OBSOLETE status and
    that you do not plan to run again.

-   The minimum duration for scaling schedules is 5 minutes.

**Creating a scaling schedule**

You can create a schedule using the Google Cloud console, gcloud CLI, or
the Compute Engine API. You can create up to 128 scaling schedules per
MIG. For more information, see [[Scaling schedule
settings]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#schedule_configuration_options).

**Note:** Consider the following when you create a scaling schedule:

-   Autoscaler never creates more than the maximum number of VM
    instances or fewer than the minimum number of VM instances
    configured in the MIG\'s autoscaling settings. Make sure the
    autoscaling settings\' maximum lets the autoscaler create the number
    of VM instances required by each scaling schedule.

-   VM instances aren\'t ready immediately at the given start time.
    Configure your start time to be early enough for VMs to boot and
    start your application before they are needed.

-   Autoscaler constantly monitors scaling schedules, so any
    configuration changes are effective immediately. For example,
    suppose you create a new schedule at 3 PM that runs every day at 2
    PM for 3 hours. This schedule becomes active shortly after it is
    created and remains active until 5 PM.

The following instructions explain how to create a scaling schedule for
a MIG.

**Permissions required for this task**

1.  In the Google Cloud console, go to the **Instance groups** page.

> [[Go to Instance
> groups]{.underline}](https://console.cloud.google.com/compute/instanceGroups)

2.  Click the name of a MIG from the list.

3.  Click create **Edit**.

4.  If no autoscaling configuration exists:

    a.  Under **Autoscaling**, click **Configure autoscaling**.

    b.  Under **Autoscaling mode**, select **On: add and remove
        instances to the group** to enable autoscaling. If you want to
        scale your MIG based only on schedules, delete the default CPU
        utilization metric after you add the schedules.

5.  For each scaling schedule that you want to add:

    a.  Expand the **Autoscaling schedules** section, click **Manage
        schedules**, then click **Create schedule**.

    b.  In the **Create scaling schedule** pane, enter a **Name**.

    c.  Optional: Enter a **Description**.

    d.  Enter the number of [**[Minimum required
        instances]{.underline}**](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#minimum_required_instances) that
        this schedule provides when it is active.

    e.  Specify the start time and recurrence of your scaling schedule
        either by using the default interface or, if you want to
        configure a schedule with a more complex start time and
        recurrence, by using a [[cron
        expression]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#cron_expressions).

        -   Default interface

            i.  In the **Start time** field, type or
                click access_time to select a start time.

            ii. In the **Recurrence** field, select how often the
                schedule repeats. If you select **Every
                week** or **Every month**, use the additional drop-down
                menu to select which days of the week or month the
                schedule starts.

        -   Cron expression

            i.  To enable, click the **Use CRON expression** toggle.

            ii. Enter a [**[CRON
                expression]{.underline}**](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#cron_expressions).

    f.  In the **Time zone** field, select a time zone.

> **Note:** Some locations observe daylight saving time (DST). For more
> information, see [[Time
> zones]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#time_zone).

g.  In the **Duration** and **Unit of time** fields, enter a duration
    and select a corresponding unit of time.

h.  Click **Save**. The **Scaling schedules** pane opens.

i.  Optional: You can create another scaling schedule by
    clicking add **Create schedule**.

```{=html}
<!-- -->
```
6.  When you are finished creating schedules, click **Done**.

7.  To close the **Instance groups** page, click **Save**.

After a schedule is created, you might need to wait a few minutes to see
its [[status
information]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#schedule_status_information).

**Listing your scaling schedules**

You can view a list of the schedules for a MIG by using the Google Cloud
console, gcloud CLI, or the Compute Engine API. The list shows each
schedule\'s [[settings]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#schedule_configuration_options) and [[status
information]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#schedule_status_information).

**Permissions required for this task**

[[Console](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#console)[gcloud](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#gcloud)[API](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#api)]{.underline}

1.  In the Google Cloud console, go to the **Instance groups** page.

> [[Go to Instance
> groups]{.underline}](https://console.cloud.google.com/compute/instanceGroups)

2.  Click the name of a MIG from the list.

3.  Click create **Edit**.

4.  You can see the total number of schedules under **Autoscaling
    schedules**. Click **Manage schedules** to display the list of your
    existing scaling schedules.

When you are finished, you can close the list by clicking **Done**.

**Editing a scaling schedule**

You can edit an [[existing scaling
schedule]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#listing_your_scaling_schedules) to
change any of
its [[settings]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#schedule_configuration_options) except
for the name of the schedule. You can also [[disable or re-enable a
scaling
schedule]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#disabling_and_re-enabling_a_scaling_schedule).

**Permissions required for this task**

1.  In the Google Cloud console, go to the **Instance groups** page.

> [[Go to Instance
> groups]{.underline}](https://console.cloud.google.com/compute/instanceGroups)

2.  Click the name of a MIG from the list.

3.  Click create **Edit**.

4.  You can see the total number of schedules under **Autoscaling
    schedules**. Click **Manage schedules** to display the list of your
    existing scaling schedules.

5.  Select the checkbox for the scaling schedule that you want to edit.

6.  At the top of the **Scaling Schedules** pane, click create **Edit**.

7.  In the new **Edit scaling schedule** pane, modify the fields that
    you want to change. For more information about each field,
    see [[Creating a scaling
    schedule]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#creating_a_scaling_schedule).

8.  When you are finished, click **Save**.

You might need to wait a few minutes before your changes are effective.
You can monitor the status of your schedules by
clicking refresh **Refresh** at the top of the **Scaling
Schedules** pane.

When you are finished, you can close the list by clicking **Done**.

**Disabling and re-enabling a scaling schedule**

Scaling schedules are enabled by default. Disable a schedule if you want
to prevent a schedule from being active but want to save its
configuration. Re-enable a disabled schedule when you want to use it
again.

If you do not need to store the schedule or have reached the 128
schedule limit for this MIG, [[delete the
schedule]{.underline}](https://cloud.google.com/compute/docs/autoscaler/scaling-schedules#deleting_a_scaling_schedule).
If you want to disable autoscaling for a MIG, [[turn off
autoscaling]{.underline}](https://cloud.google.com/compute/docs/autoscaler/managing-autoscalers#turn_off_or_restrict_an_autoscaler).

**Permissions required for this task**

1.  In the Google Cloud console, go to the **Instance groups** page.

> [[Go to Instance
> groups]{.underline}](https://console.cloud.google.com/compute/instanceGroups)

2.  Click the name of a MIG from the list.

3.  Click create **Edit**.

4.  You can see the total number of schedules under **Autoscaling
    schedules**. Click **Manage schedules** to display the list of your
    existing scaling schedules.

5.  Select the checkboxes for the scaling schedules that you want to
    disable or enable.

6.  Disable or enable the selected schedules.

    -   To disable the selected schedules:

        a.  At the top of the **Scaling Schedules** pane,
            click remove_circle_outline **Disable**.

        b.  In the new **Disable schedules** dialog, click **Disable**.

    -   To enable the selected schedules:

        a.  At the top of the **Scaling Schedules** pane,
            click check_circle_outline **Enable**.

        b.  In the new **Enable schedules** dialog, click **Enable**.

You might need to wait a few minutes before your changes are effective.
You can monitor the status of your schedules by
clicking refresh **Refresh** at the top of the **Scaling
Schedules** pane.

When you are finished, you can close the list by clicking **Done**.
