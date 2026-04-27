import React, { useState, useEffect, useRef } from 'react';
import { motion, useMotionValue, useTransform, useSpring } from 'framer-motion';
import { 
  FaGithub, FaLinkedin, FaEnvelope, FaDownload, FaAws, FaMicrosoft, FaChartBar 
} from 'react-icons/fa';
import { 
  SiReact, SiNodedotjs, SiTypescript, SiDotnet, 
  SiDocker, SiLinux, SiGithub, SiPython 
} from 'react-icons/si';
import profilePic from '../assets/profile2.webp';
import cvFile from '../assets/Farmanullah Ansari CV - All.pdf';

const ROLES = [
  'Full-Stack Developer',
  'MERN Stack Engineer',
  'ASP.NET Core Developer',
  'Cloud & DevOps Enthusiast',
  'TypeScript Developer',
  'Docker & Containerization Specialist',
  'Data Analyst & Power BI Developer',
  'Software Engineer',
  // New Additions:
  'Backend API Architect',
  'Frontend Specialist (React)',
  'Cloud Infrastructure Engineer',
  'Cross-Platform Solutions Developer',
  'Open Source Contributor',
  'Logic & Game Engine Developer'
];

const SOCIALS = [
  { href: 'https://github.com/farmanullah1',                icon: <FaGithub />,   label: 'GitHub'   },
  { href: 'https://www.linkedin.com/in/farmanullah-ansari', icon: <FaLinkedin />, label: 'LinkedIn' },
];

const STATS = [
  { num: '3+',  label: 'Years Coding'   },
  { num: '10+', label: 'Projects Built' },
  { num: '10+', label: 'Certifications' },
];

/* Enhanced float badges — cleaner labels, better orbital positions */
const FLOAT_BADGES = [
  { text: 'React.js',      icon: <SiReact color="#61DAFB" />,      cls: 'fb--1',  dy: [-12, 0, -12], dur: 3.0 },
  { text: 'Node.js',       icon: <SiNodedotjs color="#339933" />,  cls: 'fb--2',  dy: [-9,  0,  -9], dur: 3.8 },
  { text: 'AWS',           icon: <FaAws color="#FF9900" />,        cls: 'fb--3',  dy: [ 11, 0,  11], dur: 3.3 },
  { text: 'TypeScript',    icon: <SiTypescript color="#3178C6" />, cls: 'fb--4',  dy: [ 10, 0,  10], dur: 3.5 },
  { text: 'C# / .NET',     icon: <FaMicrosoft color="#00A4EF" />,  cls: 'fb--5',  dy: [-14, 0, -14], dur: 4.0 },
  { text: 'ASP.NET Core',  icon: <SiDotnet color="#512BD4" />,     cls: 'fb--6',  dy: [-8,  0,  -8], dur: 3.2 },
  { text: 'Docker',        icon: <SiDocker color="#2496ED" />,     cls: 'fb--7',  dy: [ 12, 0,  12], dur: 3.6 },
  { text: 'Linux',         icon: <SiLinux color="#FCC624" />,      cls: 'fb--8',  dy: [  7, 0,   7], dur: 3.9 },
  { text: 'Git & GitHub',  icon: <SiGithub color="#F05032" />,     cls: 'fb--9',  dy: [-11, 0, -11], dur: 3.4 },
  { text: 'Power BI',      icon: <FaChartBar color="#F2C811" />,   cls: 'fb--10', dy: [-13, 0, -13], dur: 4.2 },
  { text: 'Python',        icon: <SiPython color="#3776AB" />,     cls: 'fb--11', dy: [  9, 0,   9], dur: 3.7 },
];

const container = {
  hidden: {},
  show: { transition: { staggerChildren: 0.09, delayChildren: 0.15 } },
};
const item = {
  hidden: { opacity: 0, y: 28 },
  show:   { opacity: 1, y: 0, transition: { duration: 0.55, ease: [0.4, 0, 0.2, 1] } },
};

const Hero = () => {
  const [roleIndex,     setRoleIndex]     = useState(0);
  const [displayedRole, setDisplayedRole] = useState('');
  const [isTyping,      setIsTyping]      = useState(true);

  const imageRef = useRef(null);
  const mx = useMotionValue(0);
  const my = useMotionValue(0);
  const smx = useSpring(mx, { stiffness: 120, damping: 20 });
  const smy = useSpring(my, { stiffness: 120, damping: 20 });
  const rotateX = useTransform(smy, [-0.5, 0.5], [8, -8]);
  const rotateY = useTransform(smx, [-0.5, 0.5], [-8, 8]);

  const handleMouseMove = (e) => {
    const rect = imageRef.current?.getBoundingClientRect();
    if (!rect) return;
    mx.set((e.clientX - rect.left) / rect.width - 0.5);
    my.set((e.clientY - rect.top)  / rect.height - 0.5);
  };
  const handleMouseLeave = () => { mx.set(0); my.set(0); };

  useEffect(() => {
    const target = ROLES[roleIndex];
    let t;
    if (isTyping) {
      if (displayedRole.length < target.length) {
        t = setTimeout(() => setDisplayedRole(target.slice(0, displayedRole.length + 1)), 58);
      } else {
        t = setTimeout(() => setIsTyping(false), 1900);
      }
    } else {
      if (displayedRole.length > 0) {
        t = setTimeout(() => setDisplayedRole(displayedRole.slice(0, -1)), 32);
      } else {
        setRoleIndex((p) => (p + 1) % ROLES.length);
        setIsTyping(true);
      }
    }
    return () => clearTimeout(t);
  }, [displayedRole, isTyping, roleIndex]);

  return (
    <motion.header className="hero" id="home" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 0.7 }}>
      {/* Background */}
      <div className="hero-bg" aria-hidden="true">
        <div className="hero-orb hero-orb--purple" />
        <div className="hero-orb hero-orb--pink"   />
        <div className="hero-orb hero-orb--cyan"   />
        <div className="hero-orb hero-orb--teal"   />
        <div className="hero-grid" />
      </div>

      <div className="hero-inner">
        {/* LEFT */}
        <motion.div className="hero-content" variants={container} initial="hidden" animate="show">
          <motion.div className="hero-badge" variants={item}>
            <span className="blink-dot" />
            Available for new opportunities
          </motion.div>

          <motion.h1 className="hero-greeting" variants={item}>
            Hi, I'm
            <span className="hero-name">Farmanullah Ansari</span>
          </motion.h1>

          <motion.h3 className="hero-role" variants={item}>
            <span className="role-prefix">I'm a&nbsp;</span>
            <span className="role-text">{displayedRole}</span>
            <span className="typing-cursor" />
          </motion.h3>

          <motion.p className="hero-desc" variants={item}>
            I engineer dynamic, user-friendly, and scalable web applications. Passionate about
            the MERN stack, ASP.NET Core, cloud computing, and building seamless digital experiences.
          </motion.p>

          <motion.div className="hero-stats" variants={item}>
            {STATS.map((s, i) => (
              <motion.div className="stat-item" key={i}
                initial={{ opacity: 0, scale: 0.6 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: 0.65 + i * 0.12, type: 'spring', stiffness: 220 }}>
                <span className="stat-num">{s.num}</span>
                <span className="stat-label">{s.label}</span>
              </motion.div>
            ))}
          </motion.div>

          <motion.div className="hero-actions" variants={item}>
            <a href="#contact" className="btn-primary"><FaEnvelope /> Hire Me</a>
            <a href={cvFile} download="Farmanullah_Ansari_CV.pdf" className="btn-secondary"><FaDownload /> Download CV</a>
          </motion.div>

          <motion.div className="hero-social" variants={item}>
            {SOCIALS.map((s, i) => (
              <motion.a key={i} href={s.href} target="_blank" rel="noreferrer" aria-label={s.label}
                whileHover={{ y: -7, scale: 1.15 }} whileTap={{ scale: 0.9 }}
                transition={{ type: 'spring', stiffness: 320, damping: 16 }}>
                {s.icon}
              </motion.a>
            ))}
            <span className="hero-social-label">Let's connect</span>
          </motion.div>
        </motion.div>

        {/* RIGHT — tilt card */}
        <motion.div className="hero-image-container"
          initial={{ opacity: 0, scale: 0.5, x: 70 }}
          animate={{ opacity: 1, scale: 1, x: 0 }}
          transition={{ delay: 0.28, duration: 0.9, type: 'spring', stiffness: 70 }}>

          {FLOAT_BADGES.map((b, i) => (
            <motion.div key={i} className={`hero-float-badge ${b.cls}`}
              animate={{ y: b.dy }}
              transition={{ duration: b.dur, repeat: Infinity, repeatType: 'mirror', ease: 'easeInOut' }}>
              <span className="badge-icon">{b.icon}</span>
              {b.text}
            </motion.div>
          ))}

          <motion.div className="hero-image-wrap" ref={imageRef}
            onMouseMove={handleMouseMove} onMouseLeave={handleMouseLeave}
            style={{ rotateX, rotateY, transformPerspective: 800 }}>
            <div className="hero-ring hero-ring--dashed" />
            <div className="hero-ring hero-ring--glow"   />
            <div className="hero-ring hero-ring--pulse"  />
            <div className="hero-image">
              <img src={profilePic} alt="Farmanullah Ansari" />
            </div>
          </motion.div>
        </motion.div>
      </div>

      {/* Scroll cue */}
      <motion.div className="hero-scroll-cue" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 1.5 }}>
        <motion.div animate={{ y: [0, 10, 0] }} transition={{ duration: 1.8, repeat: Infinity, ease: 'easeInOut' }}>
          <div className="scroll-mouse"><div className="scroll-wheel" /></div>
        </motion.div>
        <span>Scroll down</span>
      </motion.div>
    </motion.header>
  );
};

export default Hero;