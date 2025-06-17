import { useEffect } from "react";
import { useRouter } from "next/router";
import { useSession } from "next-auth/react";

export default function Home() {
  const router = useRouter();
  const { status } = useSession();

  useEffect(() => {
    if (status === "authenticated") {
      router.push("/dashboard");
    } else if (status === "unauthenticated") {
      router.push("/login");
    }
  }, [status, router]);

  // Loading state while checking authentication
  return (
    <div className="flex min-h-screen items-center justify-center">
      <div className="animate-pulse">Loading...</div>
    </div>
  );
} 